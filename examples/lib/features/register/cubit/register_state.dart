part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterFailure extends RegisterState {
  final bool isValidate;

  RegisterFailure({required this.isValidate});
}

class RegisterLoading extends RegisterState {
  final bool isLoading;

  RegisterLoading(this.isLoading);
}

class RegisterCompleted extends RegisterState {
  final TempModel model;
  RegisterCompleted({required this.model});
  // final RegisterResponseModel model;

  // RegisterCompleted({required this.model});
}
