import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/apis/end_point.dart';
import 'package:pharmago_patient/data/config/dio.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/product_list/data/models/product_model.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/repositories/product_repository.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final BaseDio _dio;
  ProductRepositoryImpl(this._dio);
  
  @override
  Future<BaseResponseModel<List<ProductModel>>> getListProducts({
    required int? page,
    required int? limit,
    String? keySearch,
    String? orderBy,
    String? workspace,
  }) async {
    try {
      final Map<String, String> params = {
        'page': page.toString(),
        'limit': limit.toString(),
        'order_by': orderBy ?? '-time_created',
        if (keySearch != null && keySearch != '') 'search': keySearch,
        if (workspace != null && workspace != '') 'workspace': workspace,
      };

      final res =
          await _dio.dio().get(Api.productList, queryParameters: params);
      final data = (res.data['data']['items'] as List)
          .map((e) => ProductModel.fromJson(e))
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
}
