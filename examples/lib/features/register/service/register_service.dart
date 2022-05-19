import 'dart:io';

import 'package:dio/dio.dart';

import '../model/register_request_model.dart';
import '../model/register_response_model.dart';

abstract class IRegisterService {
  final Dio dio;

  IRegisterService(this.dio);
  final registerPath = IRegisterServicePath.register.rawValue;

  Future<RegisterResponseModel?> postUserData(RegisterRequestModel model);
}

class RegisterService extends IRegisterService {
  RegisterService({
    required Dio dio,
  }) : super(dio);

  @override
  Future<RegisterResponseModel?> postUserData(RegisterRequestModel model) async {
    try {
      final response = await dio.post(registerPath, data: model);
      if (response.statusCode == HttpStatus.ok) {
        return RegisterResponseModel.fromJson(response.data);
      } else {}
    } catch (e) {
      rethrow;
    }
    return null;
  }
}

enum IRegisterServicePath { register }

extension IRegisterServicePAthExtension on IRegisterServicePath {
  String get rawValue {
    switch (this) {
      case IRegisterServicePath.register:
        return '/register';
    }
  }
}
