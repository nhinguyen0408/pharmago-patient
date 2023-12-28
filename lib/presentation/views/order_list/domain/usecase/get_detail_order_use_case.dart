import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/mapper/order_mapper.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';

@injectable
class GetDetailOrderUsecase
    extends BaseFutureUseCase<GetDetailOrderInput, GetDetailOrderOutput> {
      final OrderRepository _orderRepository;
      final OrderMapper _orderMapper;
  GetDetailOrderUsecase(this._orderRepository, this._orderMapper);

  @override
  Future<GetDetailOrderOutput> buildUseCase(
      GetDetailOrderInput input) async {
    try {
      final res = await _orderRepository.getDetailOrder(
        id: input.id,
      );
      final dataEntity = _orderMapper.mapToEntity(res.data);
      return GetDetailOrderOutput(BaseResponseModel<OrderEntity>(
        code: res.code,
        data: dataEntity,
        message: res.message,
        extra: res.extra,
      ));
    } catch (e) {
      return GetDetailOrderOutput(BaseResponseModel<OrderEntity>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class GetDetailOrderInput extends BaseInput {
  final String id;

  GetDetailOrderInput({
    required this.id,
  });
}

class GetDetailOrderOutput extends BaseOutput {
  final BaseResponseModel<OrderEntity> response;

  GetDetailOrderOutput(this.response);
}
