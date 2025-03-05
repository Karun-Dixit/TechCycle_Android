import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sprint1/onboarding/presentation/view/onboardingscreen_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Onboarding Screen after 3 seconds, ensuring context is valid
    Timer(const Duration(seconds: 3), () {
      if (mounted) { // Check if widget is still mounted
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo.png'), // Logo for Splash Screen
      ),
    );
  }
}