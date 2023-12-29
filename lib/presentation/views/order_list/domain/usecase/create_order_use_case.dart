import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/mapper/order_mapper.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_item_payload.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';

@injectable
class CreateOrderUsecase
    extends BaseFutureUseCase<CreateOrderInput, CreateOrderOutput> {
      final OrderRepository _orderRepository;
      final OrderMapper _orderMapper;
  CreateOrderUsecase(this._orderRepository, this._orderMapper);

  @override
  Future<CreateOrderOutput> buildUseCase(
      CreateOrderInput input) async {
    try {
      final res = await _orderRepository.createOrder(
        address: input.address,
        orderItems: input.orderItems,
      );
      return CreateOrderOutput(BaseResponseModel<OrderEntity?>(
        code: res.code,
        message: res.message,
        extra: res.extra,
      ));
    } catch (e) {
      return CreateOrderOutput(BaseResponseModel<OrderEntity?>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class CreateOrderInput extends BaseInput {
  final int address;
  final List<OrderItemPayload> orderItems;

  CreateOrderInput({
    required this.address,
    required this.orderItems,
  });
}

class CreateOrderOutput extends BaseOutput {
  final BaseResponseModel<OrderEntity?> response;

  CreateOrderOutput(this.response);
}
