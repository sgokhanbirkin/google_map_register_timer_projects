import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/temp_model.dart';
import '../model/register_request_model.dart';
import '../model/register_response_model.dart';
import '../service/register_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final TextEditingController phoneController;

  final IRegisterService service;
  bool isLoading = false;
  bool isRegisterFail = false;

  RegisterCubit({
    required this.service,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmController,
    required this.phoneController,
  }) : super(RegisterInitial());

  void tryAgain() {
    emit(RegisterInitial());
  }

  Future<void> postUserData() async {
    changeLoading();
    final model = RegisterRequestModel(
      //name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      //phone: phoneController.text,
    );
    final tempModel = TempModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
    );

    try {
      final response = await service.postUserData(model);
      changeLoading();
      if (response is RegisterResponseModel) {
        emit(RegisterCompleted(model: tempModel));
      } else {
        changeLoading();
        isRegisterFail = true;
        emit(RegisterFailure(isValidate: isRegisterFail));
      }
    } catch (e) {
      changeLoading();
      isRegisterFail = true;
      emit(RegisterFailure(isValidate: isRegisterFail));
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    emit(RegisterLoading(isLoading));
  }
}
