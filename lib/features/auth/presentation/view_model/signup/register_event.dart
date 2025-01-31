part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class UploadImage extends RegisterEvent {
  final File file;

  const UploadImage({
    required this.file,
  });
}

class Registercustomer extends RegisterEvent {
  final BuildContext context;
  final String fName;
  final String email;
  final String? image;
  final String password;

  const Registercustomer({
    required this.context,
    required this.fName,
    required this.email,
    this.image,
    required this.password,
  });
}
