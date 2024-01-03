import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/apis/end_point.dart';
import 'package:pharmago_patient/data/config/dio.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/models/order_count_model.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/models/order_model.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_item_payload.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/variant_still_in_stock_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final BaseDio _dio;

  OrderRepositoryImpl(this._dio);
  @override
  Future<BaseResponseModel<OrderModel?>> createOrder({
    required int address,
    required List<OrderItemPayload> orderItems,
  }) async {
    try {
      final Map<String, dynamic> payload = {
        'address': address,
        'orders': orderItems
            .map((item) => {
                  'note': item.note,
                  'workspace': item.workspace,
                  'items': item.cartItems
                      .map((item) => <String, dynamic>{
                            'variant': item.variant!.id,
                            'quantity': item.quantity!,
                            'price': item.variant!.price!.toInt(),
                            'unit': item.unit!.id!,
                          })
                      .toList(),
                })
            .toList(),
      };

      final res = await _dio.dio().post(Api.order, data: payload);
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
  Future<BaseResponseModel<List<OrderModel>>> getListOrder({
    required StatusOrder status,
    String? search,
    String? limit,
    String? page,
  }) async {
    try {
      final Map<String, String> params = {
        'status': status.getValue.toString(),
        if (search != null && search != '') 'search': search,
        if (page != null && page != '') 'page': page,
        if (limit != null && limit != '') 'limit': limit,
      };

      final res = await _dio.dio().get(Api.order, queryParameters: params);
      final data = (res.data['data']['items'] as List)
          .map((e) => OrderModel.fromJson(e))
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
  Future<BaseResponseModel<List<CountOrderModel>>> countOrder() async {
    try {
      final res = await _dio.dio().get(Api.order);
      final data = (res.data['data'] as List)
          .map((e) => CountOrderModel.fromJson(e))
          .toList();
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

  @override
  Future<BaseResponseModel<OrderModel>> getDetailOrder(
      {required String id}) async {
    try {
      final res = await _dio.dio().get('${Api.order}$id/');
      final data = OrderModel.fromJson(res.data['data']);
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

  @override
  Future<BaseResponseModel<OrderModel?>> updateStatusOrder(
      {required String id, required StatusOrder status}) async {
    try {
      final payload = {
        'status': status.getValue,
      };
      final res =
          await _dio.dio().put('${Api.updateStatusOrder}$id/', data: payload);
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
  Future<BaseResponseModel<List<VariantStillInStockEntity>>>
      checkVariantStillInStock({
    required int drugstore,
    required List<VariantCheckInStockEntity> variants,
  }) async {
    try {
      final payload = {
        'workspace': drugstore,
        'variants': variants.map((e) => <String, dynamic> {
          'id': e.id!,
          'unit': e.unit!,
        }).toList(),
      };
      final res =
          await _dio.dio().post(Api.checkVariantInStock, data: payload);
      final data = (res.data['data'] as List)
          .map((e) => VariantStillInStockEntity.fromJson(e))
          .toList();
      return BaseResponseModel(
        code: res.data['code'],
        message: res.data['message'],
        data: data
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
