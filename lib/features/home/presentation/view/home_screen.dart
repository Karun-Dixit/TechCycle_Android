// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sprint1/features/home/presentation/bloc/home_bloc.dart';

// import 'package:sprint1/features/home/presentation/view/home_view.dart'; // Updated to point to DashboardScreen

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: BlocProvider.of<HomeBloc>(context, listen: false),
//       child: const DashboardScreen(), // Navigate directly to DashboardScreen with navigation
//     );
//   }
// }