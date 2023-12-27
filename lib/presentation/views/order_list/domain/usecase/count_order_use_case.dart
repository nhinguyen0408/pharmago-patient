import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/mapper/order_count_mapper.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_count_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';

@injectable
class CountOrderUsecase
    extends BaseFutureUseCase<CountOrderInput, CountOrderOutput> {
      final OrderRepository _orderRepository;
      final CountOrderMapper _orderMapper;
  CountOrderUsecase(this._orderRepository, this._orderMapper);

  @override
  Future<CountOrderOutput> buildUseCase(
      CountOrderInput input) async {
    try {
      final res = await _orderRepository.countOrder();
      final dataEntity = _orderMapper.mapToListEntity(res.data);
      return CountOrderOutput(BaseResponseModel<List<CountOrderEntity>>(
        code: res.code,
        data: dataEntity,
        message: res.message,
      ));
    } catch (e) {
      return CountOrderOutput(BaseResponseModel<List<CountOrderEntity>>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class CountOrderInput extends BaseInput {
  CountOrderInput();
}

class CountOrderOutput extends BaseOutput {
  final BaseResponseModel<List<CountOrderEntity>> response;

  CountOrderOutput(this.response);
}
