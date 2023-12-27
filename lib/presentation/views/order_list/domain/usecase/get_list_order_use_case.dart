import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/mapper/order_mapper.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';

@injectable
class GetListOrderUsecase
    extends BaseFutureUseCase<GetListOrderInput, GetListOrderOutput> {
      final OrderRepository _orderRepository;
      final OrderMapper _orderMapper;
  GetListOrderUsecase(this._orderRepository, this._orderMapper);

  @override
  Future<GetListOrderOutput> buildUseCase(
      GetListOrderInput input) async {
    try {
      final res = await _orderRepository.getListOrder(
        page: input.page.toString(),
        limit: input.limit.toString(),
        search: input.search,
        status: input.status,
      );
      final dataEntity = _orderMapper.mapToListEntity(res.data);
      return GetListOrderOutput(BaseResponseModel<List<OrderEntity>>(
        code: res.code,
        data: dataEntity,
        message: res.message,
        extra: res.extra,
      ));
    } catch (e) {
      return GetListOrderOutput(BaseResponseModel<List<OrderEntity>>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class GetListOrderInput extends BaseInput {
  final int page;
  final int limit;
  final String? search;
  final StatusOrder status;

  GetListOrderInput({
    required this.page,
    required this.limit,
    this.search,
    required this.status,
  });
}

class GetListOrderOutput extends BaseOutput {
  final BaseResponseModel<List<OrderEntity>> response;

  GetListOrderOutput(this.response);
}
