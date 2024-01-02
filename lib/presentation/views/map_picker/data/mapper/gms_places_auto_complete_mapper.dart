
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/mapper/base/data_mapper.dart';
import 'package:pharmago_patient/presentation/views/map_picker/data/models/gms_model/place_auto_complete_model.dart';
import 'package:pharmago_patient/presentation/views/map_picker/domain/entities/gms_places_auto_complete_entity.dart';

@injectable
class GMSPlaceAutoCompleteEntityMapper extends BaseDataMapper<PlaceAutoCompleteModel, GMSPlaceAutoCompleteEntity> {
  @override
  GMSPlaceAutoCompleteEntity mapToEntity(PlaceAutoCompleteModel? data) {
    return GMSPlaceAutoCompleteEntity(
      placeId: data?.placeId,
      description: data?.description,
    );
  }
}