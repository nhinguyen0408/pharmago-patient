import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/apis/end_point.dart';
import 'package:pharmago_patient/data/config/dio.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/address_model.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/repository/address_repository.dart';

@LazySingleton(as: AddressRepository)
class AddressRepositoryImpl implements AddressRepository {
  final BaseDio _dio;
  AddressRepositoryImpl(this._dio);
  
  @override
  Future<BaseResponseModel<List<AddressModel>>> getAllAddress() async {
    try {
      final res = await _dio.dio().get(Api.address);
      final data = (res.data['data']['items'] as List).map((e) => AddressModel.fromJson(e)).toList();
      return BaseResponseModel(
        code: res.data['code'],
        message: res.data['message'],
        data: data,
        extra: res.data['data']['count'],
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error =============================================== \n $e');
      }
      return BaseResponseModel(
        code: 400,
        message: e.toString(),
      );
    }
  }

}
