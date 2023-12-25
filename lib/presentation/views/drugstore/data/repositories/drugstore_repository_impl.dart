import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/apis/end_point.dart';
import 'package:pharmago_patient/data/config/dio.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/drugstore/data/models/drugstore_model.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/repositories/drugstore_repository.dart';

@LazySingleton(as: DrugstoreRepository)
class DrugstoreRepositoryImpl implements DrugstoreRepository {
  final BaseDio _dio;

  DrugstoreRepositoryImpl(this._dio);

  @override
  Future<BaseResponseModel<List<DrugstoreModel>>> getAllDrugstores({
    required int? page,
    required int? limit,
    String? keySearch,
  }) async {
    try {
      final Map<String, String> params = {
        'page' : page.toString(),
        'limit' : limit.toString(),
        if (keySearch != null && keySearch != '') 'search': keySearch,
      };

      final res = await _dio.dio().get(Api.drugstoreList, queryParameters: params);
      final data = (res.data['data']['items'] as List).map((e) => DrugstoreModel.fromJson(e)).toList();
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
  
  @override
  Future<BaseResponseModel<DrugstoreModel>> getDetailDrugstores({required String id}) async {
    try {
      final res = await _dio.dio().get('${Api.drugstoreList}$id/');
      final data =  DrugstoreModel.fromJson(res.data['data']);
      return BaseResponseModel(
        code: res.data['code'],
        message: res.data['message'],
        data: data,
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
