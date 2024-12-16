import 'package:flutter/material.dart';
import 'package:sprint1/screens/dashboard/dashboard_screen.dart';
import 'package:sprint1/screens/login/login_screen.dart';
import 'package:sprint1/screens/onboarding/onboarding_screen.dart';
import 'package:sprint1/screens/signup/signup_screen.dart';
import 'package:sprint1/screens/splash/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreenView(),
    );
  }
}