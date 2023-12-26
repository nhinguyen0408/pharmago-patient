import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/mapper/address_mapper.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/repository/address_repository.dart';

@injectable
class GetListAddressUsecase
    extends BaseFutureUseCase<GetListAddressInput, GetListAddressOutput> {
    final AddressRepository _addressRepository;
    final AddressMapper _addressMapper;

  GetListAddressUsecase(this._addressRepository, this._addressMapper);
  @override
  Future<GetListAddressOutput> buildUseCase(
      GetListAddressInput input) async {
    try {
      final res = await _addressRepository.getAllAddress();
      final dataEntity = _addressMapper.mapToListEntity(res.data);
      return GetListAddressOutput(BaseResponseModel<List<AddressEntity>>(
        code: res.code,
        data: dataEntity, 
        message: res.message,
        extra: res.extra,
      ));
    } catch (e) {
      return GetListAddressOutput(BaseResponseModel<List<AddressEntity>>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class GetListAddressInput extends BaseInput {
  GetListAddressInput();
}

class GetListAddressOutput extends BaseOutput {
  final BaseResponseModel<List<AddressEntity>> response;

  GetListAddressOutput(this.response);
}
