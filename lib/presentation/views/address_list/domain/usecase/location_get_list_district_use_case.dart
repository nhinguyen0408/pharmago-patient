import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/mapper/location_mapper.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/location_entity.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/repository/location_repository.dart';

@injectable
class GetDistrictUseCase extends BaseFutureUseCase<GetDistrictInput, GetDistrictOutput> {
  GetDistrictUseCase(this._repository, this._locationMapper);

  final LocationRepository _repository;
  final LocationMapper _locationMapper;

  @override
  Future<GetDistrictOutput> buildUseCase(GetDistrictInput input) async {
    final res = await _repository.getListDistrict(input.id);
    return GetDistrictOutput(BaseResponseModel<List<LocationEntity>>(
        code: res.isNotEmpty ? 200 : 400,
        message: res.isNotEmpty ? 'Success' : 'Failure',
        data: _locationMapper.mapToListEntity(res),
      ));
  }

}
class GetDistrictInput extends BaseInput {
  final int id;
  GetDistrictInput({required this.id});
}
class GetDistrictOutput extends BaseOutput {
  final BaseResponseModel<List<LocationEntity>> response;

  GetDistrictOutput(this.response);
}