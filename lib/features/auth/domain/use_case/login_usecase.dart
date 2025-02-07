import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sprint1/app/shared_prefs/token_shared_prefs.dart';

import '../../../../app/use_case/use_case.dart';
import '../../../../core/error/failure.dart';
import '../repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : email = '',
        password = '';

  @override
  List<Object> get props => [email, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;
  LoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    // IF api then store token in shared preferences
    return repository
        .logincustomer(params.email, params.password)
        .then((value) {
      return value.fold((failure) => Left(failure), (token) {
        tokenSharedPrefs.saveToken(token);
        tokenSharedPrefs.getToken().then((value) {
          print(value);
        });
        return Right(token);
      });
    });
  }
}
