import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/mapper/order_mapper.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_entity.dart';
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
        workspace: int.parse(input.workspace),
        address: input.address,
        note: input.note,
        cartItems: input.cartItems,
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
  final String workspace;
  final int address;
  final String? note;
  final List<CartEntity> cartItems;

  CreateOrderInput({
    required this.workspace,
    required this.address,
    this.note,
    required this.cartItems,
  });
}

class CreateOrderOutput extends BaseOutput {
  final BaseResponseModel<OrderEntity?> response;

  CreateOrderOutput(this.response);
}
