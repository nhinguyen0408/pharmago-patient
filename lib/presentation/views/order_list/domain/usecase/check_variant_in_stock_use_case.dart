import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/variant_still_in_stock_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';

@injectable
class CheckVariantInStockUsecase
    extends BaseFutureUseCase<CheckVariantInStockInput, CheckVariantInStockOutput> {
      final OrderRepository _orderRepository;
  CheckVariantInStockUsecase(this._orderRepository);

  @override
  Future<CheckVariantInStockOutput> buildUseCase(
      CheckVariantInStockInput input) async {
    try {
      final res = await _orderRepository.checkVariantStillInStock(
        drugstore: input.drugstore,
        variants: input.variants,
      );
      return CheckVariantInStockOutput(BaseResponseModel<List<VariantStillInStockEntity>>(
        code: res.code,
        data: res.data,
        message: res.message,
        extra: res.extra,
      ));
    } catch (e) {
      return CheckVariantInStockOutput(BaseResponseModel<List<VariantStillInStockEntity>>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class CheckVariantInStockInput extends BaseInput {
  final int drugstore;
  final List<VariantCheckInStockEntity> variants;

  CheckVariantInStockInput({
    required this.drugstore,
    required this.variants,
  });
}

class CheckVariantInStockOutput extends BaseOutput {
  final BaseResponseModel<List<VariantStillInStockEntity>> response;

  CheckVariantInStockOutput(this.response);
}
