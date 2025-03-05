// lib/features/splash/presentation/views/splash_screen_view.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sprint1/features/onboarding/presentation/views/onboardingscreen_view.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 1500), // Animation lasts 1.5 seconds
    );

    // Define scale animation from 0.5 to 1.0
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _animationController.forward();

    // Navigate to Onboarding Screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreenView()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
              'assets/images/logo.png'), // Logo with scale animation
        ),
      ),
    );
  }
}
