import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1/app/di/di.dart';
import 'package:sprint1/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:sprint1/features/home/presentation/view_model/home_cubit.dart';
import 'package:sprint1/splash/presentation/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeCubit>()),
        BlocProvider(create: (context) => getIt<LoginBloc>()),
      ],
      child: MaterialApp(
        title: 'TechCycle',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          brightness: Brightness.light, // Default to light mode for splash/onboarding
          useMaterial3: true,
        ),
        home: const SplashScreen(), // Start with splash screen
      ),
    );
  }
}