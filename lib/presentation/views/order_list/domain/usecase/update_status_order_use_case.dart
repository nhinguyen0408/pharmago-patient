import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';

@injectable
class UpdateStatusOrderUsecase
    extends BaseFutureUseCase<UpdateStatusOrderInput, UpdateStatusOrderOutput> {
      final OrderRepository _orderRepository;
  UpdateStatusOrderUsecase(this._orderRepository);

  @override
  Future<UpdateStatusOrderOutput> buildUseCase(
      UpdateStatusOrderInput input) async {
    try {
      final res = await _orderRepository.updateStatusOrder(
        id: input.id,
        status: input.status,
      );
      return UpdateStatusOrderOutput(BaseResponseModel<OrderEntity>(
        code: res.code,
        message: res.message,
      ));
    } catch (e) {
      return UpdateStatusOrderOutput(BaseResponseModel<OrderEntity>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class UpdateStatusOrderInput extends BaseInput {
  final String id;
  final StatusOrder status;

  UpdateStatusOrderInput({
    required this.id,
    required this.status,
  });
}

class UpdateStatusOrderOutput extends BaseOutput {
  final BaseResponseModel<OrderEntity> response;

  UpdateStatusOrderOutput(this.response);
}
