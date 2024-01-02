import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/map_picker/data/mapper/gms_geocode_mapper.dart';
import 'package:pharmago_patient/presentation/views/map_picker/domain/entities/gms_geocode_entity.dart';
import 'package:pharmago_patient/presentation/views/map_picker/domain/repositories/gms_repository.dart';

@injectable
class GMSGeocodeUseCase
    extends BaseFutureUseCase<GMSGeocodeInput, GMSGeocodeOutput> {
  final GMSRepository _gmsRepository;
  final GMSGeocodeEntityMapper _gmsGeocodeEntityMapper;

  GMSGeocodeUseCase(this._gmsRepository, this._gmsGeocodeEntityMapper);

  @override
  Future<GMSGeocodeOutput> buildUseCase(GMSGeocodeInput input) async {
    final res =
        await _gmsRepository.geocoding(address: input.addressName, placeId: input.placeId);

    return GMSGeocodeOutput(
      BaseResponseModel<GMSGeocodeEntity>(
        code: res.code,
        message: res.message,
        data: _gmsGeocodeEntityMapper.mapToEntity(res.data),
      ),
    );
  }
}

class GMSGeocodeInput extends BaseInput {
  final String? addressName;
  final String?  placeId;

  GMSGeocodeInput({
    this.addressName,
    this.placeId,
  });
}

class GMSGeocodeOutput extends BaseOutput {
  final BaseResponseModel<GMSGeocodeEntity> response;

  GMSGeocodeOutput(
    this.response,
  );
}
