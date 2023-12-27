import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/repository/address_repository.dart';

@injectable
class SetDefaultAddressUsecase
    extends BaseFutureUseCase<SetDefaultAddressInput, SetDefaultAddressOutput> {
    final AddressRepository _addressRepository;

  SetDefaultAddressUsecase(this._addressRepository);
  @override
  Future<SetDefaultAddressOutput> buildUseCase(
      SetDefaultAddressInput input) async {
    try {
      final res = await _addressRepository.setAddressDefault(input.address);
      return SetDefaultAddressOutput(BaseResponseModel<AddressEntity?>(
        code: res.code,
        message: res.message,
        extra: res.extra,
      ));
    } catch (e) {
      return SetDefaultAddressOutput(BaseResponseModel<AddressEntity?>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class SetDefaultAddressInput extends BaseInput {
  final AddressEntity address;
  SetDefaultAddressInput({ required this.address});
}

class SetDefaultAddressOutput extends BaseOutput {
  final BaseResponseModel<AddressEntity?> response;

  SetDefaultAddressOutput(this.response);
}
