import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1/app/di/di.dart';
import 'package:sprint1/features/auth/presentation/view/login_view.dart';

import '../features/auth/presentation/view_model/login/login_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tech Cycle',
      home: BlocProvider.value(
        value: getIt<LoginBloc>(),
        child: LoginView(),
      ),
    );
  }
}
