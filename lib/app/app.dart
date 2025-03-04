import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1/app/di/di.dart';
import 'package:sprint1/features/auth/presentation/view/login_view.dart';
import 'package:sprint1/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:sprint1/features/home/presentation/bloc/home_bloc.dart';
import 'package:sprint1/features/home/presentation/view/bottom_navigation_bar.dart';
import 'package:sprint1/features/home/presentation/view_model/home_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<LoginBloc>()),
        BlocProvider.value(value: getIt<HomeBloc>()),
        BlocProvider(create: (_) => HomeCubit()), // HomeCubit not in getIt, so created here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tech Cycle',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        home: LoginView(),
        routes: {
          '/home': (context) => const CustomBottomNavigationBar(),
        },
      ),
    );
  }
}