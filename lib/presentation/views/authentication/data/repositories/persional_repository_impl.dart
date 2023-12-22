import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/apis/end_point.dart';
import 'package:pharmago_patient/data/config/dio.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/authentication/data/models/persional_profile_model.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/repositories/persional_repository.dart';

@LazySingleton(as: PersionalRepository)
class PersionalRepositoryImpl implements PersionalRepository {
  final BaseDio _dio;

  PersionalRepositoryImpl(this._dio);

  @override
  Future<BaseResponseModel<PersionalProfileModel>> getPersionalProfile() async {
    try {
      final res = await _dio.dio().get(Api.persionalProfile);
      final data = PersionalProfileModel.fromJson(res.data['data']);
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
}
