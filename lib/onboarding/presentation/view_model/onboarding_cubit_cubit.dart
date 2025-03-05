import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_cubit_state.dart';

class OnboardingCubitCubit extends Cubit<OnboardingCubitState> {
  OnboardingCubitCubit() : super(OnboardingCubitInitial());
}
