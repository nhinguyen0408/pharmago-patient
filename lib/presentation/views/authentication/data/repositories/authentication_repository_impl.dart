import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/views/authentication/data/models/response_register_model.dart';

import '../../../../../data/apis/end_point.dart';
import '../../../../../data/config/dio.dart';
import '../../../../../data/models/base/response.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../models/response_authen_model.dart';

@LazySingleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final BaseDio _dio;

  AuthenticationRepositoryImpl(this._dio);

  @override
  Future<BaseResponseModel<ResponseAuthModel>> userLogin({
    required String username,
    required String password,
  }) async {
    try {
      final res = await _dio.dio().post(
        Api.login,
        data: {
          'username': username,
          'password': password,
          // 'system_code': 'ADMIN',
        },
      );
      final data = ResponseAuthModel.fromJson(res.data['data']);
      return BaseResponseModel(
        code: res.data['code'],
        message: res.data['message'],
        data: data,
      );
    } catch (e) {
      if(kDebugMode) {
        print('Error =============================================== \n $e');
      }
      return BaseResponseModel(
        code: 400,
        message: e.toString(),
      );
    }
  }

  @override
  Future<BaseResponseModel<ResponseRegisterModel>> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final payload = {
        'username': phone,
        'phone': phone,
        'password': password,
        'email': email,
        // 'account_type': accountType,
      };
      final res = await _dio.dio().post(Api.register, data: payload);
      return BaseResponseModel(
        code: res.data['code'],
        message: res.data['message'],
      );
    } catch (e) {
      if(kDebugMode) {
        print('Error =============================================== \n $e');
      }
      return BaseResponseModel(
        code: 400,
        message: e.toString(),
      );
    }
  }

  @override
  Future<BaseResponseModel<bool>> verify({
    required String email,
    required String otp,
  }) async {
    try {
      final Map<String, String> payload = {
        'email': email,
        'otp': otp,
      };
      final res = await _dio.dio().get(Api.activate, queryParameters: payload);
      return BaseResponseModel(
        code: res.data['code'],
        message: res.data['message'],
        data: res.data['details'],
      );
    } catch (e) {
      if(kDebugMode) {
        print('Error =============================================== \n $e');
      }
      return BaseResponseModel(
        code: 400,
        message: e.toString(),
      );
    }
  }
  
  @override
  Future<BaseResponseModel> reSendOTP({required String email}) async {
    try {
      final Map<String, String> payload = {
        'email': email,
      };
      final res = await _dio.dio().post(Api.reSendOTP, data: payload);
      return BaseResponseModel(
        code: res.data['code'],
        message: res.data['message'],
        data: res.data['data'],
      );
    } catch (e) {
      if(kDebugMode) {
        print('Error =============================================== \n $e');
      }
      return BaseResponseModel(
        code: 400,
        message: e.toString(),
      );
    }
  }
}
