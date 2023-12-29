import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/payload/address_payload_model.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/repository/address_repository.dart';

@injectable
class UpdateAddressUsecase
    extends BaseFutureUseCase<UpdateAddressInput, UpdateAddressOutput> {
  final AddressRepository _addressRepository;

  UpdateAddressUsecase(this._addressRepository);
  @override
  Future<UpdateAddressOutput> buildUseCase(UpdateAddressInput input) async {
    try {
      final res = await _addressRepository.updateAddress(
          address: input.address, id: input.id);
      return UpdateAddressOutput(BaseResponseModel<AddressEntity?>(
        code: res.code,
        message: res.message,
        extra: res.extra,
      ));
    } catch (e) {
      return UpdateAddressOutput(BaseResponseModel<AddressEntity?>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class UpdateAddressInput extends BaseInput {
  final AddressPayloadModel address;
  final int id;
  UpdateAddressInput({
    required this.address,
    required this.id,
  });
}

class UpdateAddressOutput extends BaseOutput {
  final BaseResponseModel<AddressEntity?> response;

  UpdateAddressOutput(this.response);
}
