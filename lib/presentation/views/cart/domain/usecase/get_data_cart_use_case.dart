import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/cart/data/mapping/cart_mapping.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/repositories/cart_repository.dart';

@injectable
class GetDataCartUsecase
    extends BaseFutureUseCase<GetDataCartInput, GetDataCartOutput> {

      final CartRepository _cartRepository;
      final CartMapping _cartMapping;

  GetDataCartUsecase(this._cartRepository, this._cartMapping);
  @override
  Future<GetDataCartOutput> buildUseCase(
      GetDataCartInput input) async {
    try {
      final res = await _cartRepository.getCart();
      final dataEntity = _cartMapping.mapToListEntity(res.data);
      return GetDataCartOutput(BaseResponseModel<List<CartEntity>>(
        code: res.code,
        data: dataEntity, 
        message: res.message,
        extra: res.extra,
      ));
    } catch (e) {
      return GetDataCartOutput(BaseResponseModel<List<CartEntity>>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class GetDataCartInput extends BaseInput {
  GetDataCartInput();
}

class GetDataCartOutput extends BaseOutput {
  final BaseResponseModel<List<CartEntity>> response;

  GetDataCartOutput(this.response);
}
