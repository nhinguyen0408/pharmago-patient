
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/mapper/location_mapper.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/location_entity.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/repository/location_repository.dart';

@injectable
class GetProvinceUseCase extends BaseFutureUseCase<GetProvinceUseInput, GetProvinceUseOutput> {
  GetProvinceUseCase(this._repository, this._locationMapper);

  final LocationRepository _repository;
  final LocationMapper _locationMapper;

  @override
  Future<GetProvinceUseOutput> buildUseCase(GetProvinceUseInput input) async {
    final res = await _repository.getListProvince();
    return GetProvinceUseOutput(BaseResponseModel<List<LocationEntity>>(
        code: res.isNotEmpty ? 200 : 400,
        message: res.isNotEmpty ? 'Success' : 'Failure',
        data: _locationMapper.mapToListEntity(res),
      ));
  }

}
class GetProvinceUseInput extends BaseInput {}
class GetProvinceUseOutput extends BaseOutput {
  final BaseResponseModel<List<LocationEntity>> response;

  GetProvinceUseOutput(this.response);
}