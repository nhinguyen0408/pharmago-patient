import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/mapper/location_mapper.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/location_entity.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/repository/location_repository.dart';

@injectable
class GetWardUseCase extends BaseFutureUseCase<GetWardInput, GetWardOutput> {
  GetWardUseCase(this._repository, this._locationMapper);

  final LocationRepository _repository;
  final LocationMapper _locationMapper;

  @override
  Future<GetWardOutput> buildUseCase(GetWardInput input) async {
    final res = await _repository.getListWard(input.id);
    return GetWardOutput(BaseResponseModel<List<LocationEntity>>(
        code: res.isNotEmpty ? 200 : 400,
        message: res.isNotEmpty ? 'Success' : 'Failure',
        data: _locationMapper.mapToListEntity(res),
      ));
  }

}
class GetWardInput extends BaseInput {
  final int id;
  GetWardInput({required this.id});
}
class GetWardOutput extends BaseOutput {
  final BaseResponseModel<List<LocationEntity>> response;

  GetWardOutput(this.response);
}