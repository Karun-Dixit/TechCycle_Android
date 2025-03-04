import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/app/di/di.dart';
import 'package:sprint1/features/auth/presentation/view/login_view.dart';
import 'package:sprint1/features/auth/presentation/view_model/login/login_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial()) {
    _loadTheme(); // Load saved theme on initialization
  }

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void toggleTheme(bool isDark) async {
    final themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: themeMode));
    _saveTheme(isDark); // Persist the choice
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
}