import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/models/order_count_model.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/models/order_model.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_item_payload.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/variant_still_in_stock_entity.dart';

enum StatusOrder {
  NEW,
  TRANSPORT,
  COMPLETE,
  CANCEL,
}

extension StatusOrderExtension on StatusOrder {
  int get getValue {
    switch (this) {
      case StatusOrder.NEW:
        return 1;
      case StatusOrder.TRANSPORT:
        return 2;
      case StatusOrder.COMPLETE:
        return 3;
      case StatusOrder.CANCEL:
        return 4;
      default:
        throw Exception('Unknown status');
    }
  }
}

abstract class OrderRepository {
  Future<BaseResponseModel<List<OrderModel>>> getListOrder({
    required StatusOrder status,
    String? search,
    String? limit,
    String? page,
  });

  Future<BaseResponseModel<OrderModel>> getDetailOrder({
    required String id,
  });

  Future<BaseResponseModel<OrderModel?>> updateStatusOrder({
    required String id,
    required StatusOrder status,
  });

  Future<BaseResponseModel<List<CountOrderModel>>> countOrder();

  Future<BaseResponseModel<OrderModel?>> createOrder({
    required int address,
    required List<OrderItemPayload> orderItems,
  });

  Future<BaseResponseModel<List<VariantStillInStockEntity>>> checkVariantStillInStock({
    required int drugstore,
    required List<VariantCheckInStockEntity> variants,
  });
}