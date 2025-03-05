import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1/app/di/di.dart';
import 'package:sprint1/features/auth/presentation/view/login_view.dart';
import 'package:sprint1/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:sprint1/features/home/presentation/bloc/home_bloc.dart';
import 'package:sprint1/features/home/presentation/view/bottom_navigation_bar.dart';
import 'package:sprint1/features/home/presentation/view_model/home_cubit.dart';
import 'package:sprint1/features/home/presentation/view_model/home_state.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<LoginBloc>()),
        BlocProvider.value(value: getIt<HomeBloc>()),
        BlocProvider(create: (_) => HomeCubit()),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            previous.themeMode != current.themeMode,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tech Cycle',
            theme: ThemeData(
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.grey[100],
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              cardTheme: const CardTheme(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                color: Colors.white,
              ),
              textTheme: const TextTheme(
                // Removed 'const' to allow Colors.grey[300]
                bodyLarge: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                bodyMedium: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.grey[900],
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[850],
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              cardTheme: CardTheme(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 12.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                color: Colors.grey[800],
              ),
              textTheme: TextTheme(
                // Removed 'const' to allow Colors.grey[300]
                bodyLarge: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                bodyMedium: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            themeMode: state.themeMode,
            home: LoginView(),
            routes: {
              '/home': (context) => const CustomBottomNavigationBar(),
            },
          );
        },
      ),
    );
  }
}
