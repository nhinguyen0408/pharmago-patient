import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/payload/address_payload_model.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/repository/address_repository.dart';

@injectable
class CreateAddressUsecase
    extends BaseFutureUseCase<CreateAddressInput, CreateAddressOutput> {
    final AddressRepository _addressRepository;

  CreateAddressUsecase(this._addressRepository);
  @override
  Future<CreateAddressOutput> buildUseCase(
      CreateAddressInput input) async {
    try {
      final res = await _addressRepository.createAddress(address: input.address);
      return CreateAddressOutput(BaseResponseModel<AddressEntity?>(
        code: res.code,
        message: res.message,
        extra: res.extra,
      ));
    } catch (e) {
      return CreateAddressOutput(BaseResponseModel<AddressEntity?>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class CreateAddressInput extends BaseInput {
  final AddressPayloadModel address;
  CreateAddressInput({ required this.address});
}

class CreateAddressOutput extends BaseOutput {
  final BaseResponseModel<AddressEntity?> response;

  CreateAddressOutput(this.response);
}
