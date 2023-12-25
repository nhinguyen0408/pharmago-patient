import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/cart/data/models/cart_payload_model.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/repositories/cart_repository.dart';

@injectable
class AddCartUsecase
    extends BaseFutureUseCase<AddCartInput, AddCartOutput> {
  final CartRepository _cartRepository;

  AddCartUsecase(this._cartRepository);
  @override
  Future<AddCartOutput> buildUseCase(AddCartInput input) async {
    try {
      final payload = CartPayloadModel(
        variant: input.variant,
        unit: input.unit,
        quantity: input.quantity,
      );
      final res = await _cartRepository.addCart(data: payload);
      return AddCartOutput(BaseResponseModel<CartEntity?>(
        code: res.code,
        message: res.message,
      ));
    } catch (e) {
      return AddCartOutput(BaseResponseModel<CartEntity?>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class AddCartInput extends BaseInput {
  final int variant;
  final int unit;
  final int quantity;

  AddCartInput({
    required this.variant,
    required this.unit,
    required this.quantity,
  });
}

class AddCartOutput extends BaseOutput {
  final BaseResponseModel<CartEntity?> response;

  AddCartOutput(this.response);
}
