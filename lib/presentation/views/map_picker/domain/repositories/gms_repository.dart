
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/map_picker/data/models/gms_model/geocode_model.dart';

import '../../data/models/gms_model/place_auto_complete_model.dart';

abstract class GMSRepository {
  Future<BaseResponseModel<List<PlaceAutoCompleteModel>>> placesAutocomplete({
    required String address,
  });

  Future<void> placesDetail();

  Future<BaseResponseModel<GeocodeModel>> geocoding({
    String? address,
    String? placeId,
  });
}