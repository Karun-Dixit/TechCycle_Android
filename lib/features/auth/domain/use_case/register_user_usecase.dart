import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/use_case/use_case.dart';
import '../../../../core/error/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fName;
  final String email;
  final String? image;
  final String password;

  const RegisterUserParams({
    required this.fName,
    required this.email,
    this.image,
    required this.password,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.fName,
    required this.email,
    this.image,
    required this.password,
  });

  @override
  List<Object?> get props => [fName, email, image, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fName: params.fName,
      email: params.email,
      image: params.image,
      password: params.password,
    );
    return repository.registercustomer(authEntity);
  }
}
