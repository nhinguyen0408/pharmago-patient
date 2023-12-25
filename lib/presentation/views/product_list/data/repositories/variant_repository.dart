import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:pharmago_patient/data/apis/end_point.dart';
import 'package:pharmago_patient/data/config/dio.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/product_list/data/models/variant_model.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/repositories/variant_repository.dart';

@LazySingleton(as: VariantRepository)
class VariantRepositoryImpl implements VariantRepository {
  final BaseDio _dio;

  VariantRepositoryImpl(this._dio);
  @override
  Future<BaseResponseModel<List<VariantModel>>> getListVariants({
    required String drugstore,
    String? search,
    String? limit,
    String? page,
    DateTime? createdFrom,
    DateTime? createdTo,
  }) async {
    try {
      final Map<String, String> params = {
        'workspace': drugstore,
        'page': page.toString(),
        'limit': limit.toString(),
        if (search != null && search != '') 'search': search,
        if (createdFrom != null) 'created_from': DateFormat('y-M-dd').format(createdFrom),
        if (createdTo != null) 'created_to': DateFormat('y-M-dd').format(createdTo),
      };

      final res =
          await _dio.dio().get(Api.variantList, queryParameters: params);
      final data = (res.data['data']['items'] as List)
          .map((e) => VariantModel.fromJson(e))
          .toList();
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
  Future<BaseResponseModel<VariantModel>> getDetailVariant({String? id}) async {
    try {
      final res = await _dio.dio().get('${Api.variantList}$id/');
      final data = VariantModel.fromJson(res.data['data']['data']);
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
