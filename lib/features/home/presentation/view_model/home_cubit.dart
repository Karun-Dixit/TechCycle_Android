import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart'; // For accelerometer and gyroscope
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/app/di/di.dart';
import 'package:sprint1/features/auth/presentation/view/login_view.dart';
import 'package:sprint1/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:sprint1/features/services/gyroscope_sensor_service.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial()) {
    _loadTheme(); // Load saved theme on initialization
    _initializeGyroscope(); // Initialize gyroscope service in constructor
  }

  StreamSubscription<AccelerometerEvent>?
      _accelSubscription; // Accelerometer subscription, nullable for null safety
  bool _isShaking = false; // Track shake state to prevent multiple triggers
  late final GyroscopeSensorService
      _gyroscopeService; // Declare as late, initialize in constructor

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void toggleTheme(bool isDark) async {
    final themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: themeMode));
    await _saveTheme(isDark); // Persist the choice (await to ensure completion)
  }

  // Method to start listening to accelerometer for shake detection
  void startListeningToAccelerometer(BuildContext context) {
    final BuildContext currentContext = context;
    try {
      // Check if accelerometer is available
      _accelSubscription =
          accelerometerEvents.listen((AccelerometerEvent event) {
        double gForce = (event.x.abs() + event.y.abs() + event.z.abs()) /
            9.81; // Normalize to G-force
        if (gForce > 2.7 && !_isShaking) {
          // Threshold for shake (adjust as needed, matches your friend’s 2.7)
          _isShaking = true;
          print('Shake detected, navigating to login screen');
          _navigateToLogin(currentContext); // Navigate to login screen on shake
          Future.delayed(const Duration(milliseconds: 500), () {
            _isShaking =
                false; // Reset after 500ms delay, matching your friend’s delay
          });
        }
      }, onError: (error) {
        if (currentContext.mounted) {
          ScaffoldMessenger.of(currentContext).showSnackBar(
            SnackBar(content: Text('Error accessing accelerometer: $error')),
          );
        }
      });
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to initialize accelerometer: $e')),
        );
      }
    }
  }

  // Method to stop listening to accelerometer (for cleanup)
  void stopListeningToAccelerometer() {
    _accelSubscription?.cancel();
    _accelSubscription = null;
    _isShaking = false; // Reset shake state on stop
  }

  // Method to start listening to gyroscope for tilt detection to toggle dark mode
  void startListeningToGyroscope(BuildContext context) {
    final BuildContext currentContext = context;
    try {
      // Check if gyroscope is available
      _gyroscopeService
          .startListening(); // Start the gyroscope service to detect tilts
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to initialize gyroscope: $e')),
        );
      }
    }
  }

  // Method to stop listening to all sensors (for cleanup, excluding proximity)
  void stopListeningToSensors() {
    _accelSubscription?.cancel();
    _accelSubscription = null;
    _gyroscopeService.stopListening(); // Stop gyroscope service
    _isShaking = false; // Reset shake state
  }

  // Navigate to login screen on shake
  void _navigateToLogin(BuildContext context) {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<LoginBloc>(),
            child: LoginView(),
          ),
        ),
      );
    }
  }

  // Toggle dark mode on tilt (alternate between light and dark modes)
  void _toggleDarkModeOnTilt(bool _) {
    final currentThemeMode = state.themeMode;
    final newThemeMode =
        currentThemeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    toggleTheme(newThemeMode == ThemeMode.dark); // Update theme and persist
    print('Dark mode toggled to: ${newThemeMode.name}'); // Log for debugging
  }

  // Initialize gyroscope service
  void _initializeGyroscope() {
    _gyroscopeService =
        GyroscopeSensorService(onTiltChanged: _toggleDarkModeOnTilt);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    emit(state.copyWith(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
  }

  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  void logout(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: LoginView(),
            ),
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    stopListeningToSensors(); // Clean up accelerometer and gyroscope subscriptions
    return super.close();
  }
}
