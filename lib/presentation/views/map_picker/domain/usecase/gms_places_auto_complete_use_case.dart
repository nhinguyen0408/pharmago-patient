import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/map_picker/data/mapper/gms_places_auto_complete_mapper.dart';
import 'package:pharmago_patient/presentation/views/map_picker/domain/entities/gms_places_auto_complete_entity.dart';
import 'package:pharmago_patient/presentation/views/map_picker/domain/repositories/gms_repository.dart';


@injectable
class GMSPlaceAutoCompleteUseCase
    extends BaseFutureUseCase<GMSPlaceAutoCompleteInput, GMSPlaceAutoCompleteOutput> {
  final GMSRepository _gmsRepository;
  final GMSPlaceAutoCompleteEntityMapper _gmsPlaceAutoCompleteEntityMapper;

  GMSPlaceAutoCompleteUseCase(this._gmsRepository, this._gmsPlaceAutoCompleteEntityMapper);

  @override
  Future<GMSPlaceAutoCompleteOutput> buildUseCase(GMSPlaceAutoCompleteInput input) async {
    final res =
        await _gmsRepository.placesAutocomplete(address: input.addressName ?? '');

    return GMSPlaceAutoCompleteOutput(
      BaseResponseModel<List<GMSPlaceAutoCompleteEntity>>(
        code: res.code,
        message: res.message,
        data: _gmsPlaceAutoCompleteEntityMapper.mapToListEntity(res.data),
      ),
    );
  }
}

class GMSPlaceAutoCompleteInput extends BaseInput {
  final String? addressName;

  GMSPlaceAutoCompleteInput({
    this.addressName,
  });
}

class GMSPlaceAutoCompleteOutput extends BaseOutput {
  final BaseResponseModel<List<GMSPlaceAutoCompleteEntity>> response;

  GMSPlaceAutoCompleteOutput(
    this.response,
  );
}
