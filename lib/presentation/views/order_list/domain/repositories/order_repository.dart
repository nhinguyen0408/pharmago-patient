import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/models/order_count_model.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/models/order_model.dart';

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

  Future<BaseResponseModel<List<CountOrderModel>>> countOrder();

  Future<BaseResponseModel<OrderModel?>> createOrder({
    required int workspace,
    required int address,
    String? note,
    required List<CartEntity> cartItems,
  });
}