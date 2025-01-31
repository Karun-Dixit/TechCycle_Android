import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fName;
  final String? image;
  final String email;

  final String password;

  const AuthEntity({
    this.userId,
    required this.fName,
    required this.email,
    required this.image,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, fName, image, email, image, password];
}
