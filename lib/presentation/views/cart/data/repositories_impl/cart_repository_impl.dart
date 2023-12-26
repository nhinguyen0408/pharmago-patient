import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/apis/end_point.dart';
import 'package:pharmago_patient/data/config/dio.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/cart/data/models/cart_model.dart';
import 'package:pharmago_patient/presentation/views/cart/data/models/cart_payload_model.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/repositories/cart_repository.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final BaseDio _dio;
  CartRepositoryImpl(this._dio);

  @override
  Future<BaseResponseModel<CartModel?>> addCart({required CartPayloadModel data}) async {
    try {
      final res = await _dio.dio().post(Api.cart, data: data.toJson());
      return BaseResponseModel(
        code: res.data['code'],
        message: res.data['message'],
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
  Future<BaseResponseModel<CartModel?>> deleteCart({required CartPayloadModel data}) async {
    try {
      final res = await _dio.dio().delete(Api.cart, data: data.toJson());
      return BaseResponseModel(
        code: res.data['code'],
        message: res.data['message'],
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
  Future<BaseResponseModel<List<CartModel>>> getCart() async {
    try {
      final res = await _dio.dio().get(Api.cart);
      final data = (res.data['data']['items'] as List).map((e) => CartModel.fromJson(e)).toList();
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