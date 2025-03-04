import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import
import 'package:sprint1/app/di/di.dart';
import 'package:sprint1/features/home/presentation/bloc/home_bloc.dart';
import 'package:sprint1/features/home/presentation/view/home_view.dart';

import '../../../../../core/common/snack_bar/my_snackbar.dart';
import '../../../../home/presentation/view_model/home_cubit.dart';
import '../../../domain/use_case/login_usecase.dart';
import '../signup/register_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  final LoginUseCase _loginUseCase;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    required LoginUseCase loginUseCase,
  })  : _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _registerBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<NavigateHomeScreenEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _homeCubit), // Provide HomeCubit
                BlocProvider.value(
                  value: getIt<HomeBloc>(), // Provide HomeBloc from get_it
                ),
              ],
              child: const DashboardScreen(
              ),
            ),
          ),
        );
      },  
    );

    on<LogincustomerEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final result = await _loginUseCase(
          LoginParams(
            email: event.email,
            password: event.password,
          ),
        );

        result.fold(
          (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
            showMySnackBar(
              context: event.context,
              message: "Invalid Credentials",
              color: Colors.red,
            );
          },
          (token) async {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            // Store the token in SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', token);
            add(
              NavigateHomeScreenEvent(
                context: event.context,
                destination: const DashboardScreen(),
              ),
            );
            //_homeCubit.setToken(token); // Uncomment or update if needed
          },
        );
      },
    );
  }
}
