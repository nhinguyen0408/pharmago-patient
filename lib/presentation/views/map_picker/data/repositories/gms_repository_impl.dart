import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/apis/end_point.dart';
import 'package:pharmago_patient/data/config/dio.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/map_picker/domain/repositories/gms_repository.dart';
import 'package:pharmago_patient/shared/constants/pref_key.dart';

import '../models/gms_model/geocode_model.dart';
import '../models/gms_model/place_auto_complete_model.dart';

@LazySingleton(as: GMSRepository)
class GMSRepositoryImpl extends GMSRepository {
  final BaseDio _dio;

  GMSRepositoryImpl(this._dio);

  @override
  Future<BaseResponseModel<List<PlaceAutoCompleteModel>>> placesAutocomplete({
    required String address,
  }) async {
    final res = await _dio.dio().get(
          '${Api.urlGMS}/place/autocomplete/json?input=$address&language=vn&key=${PrefKeys.GMSToken}',
        );
    try {
      return BaseResponseModel(
        code: res.statusCode,
        data: (res.data['predictions'] as List)
            .map((e) => PlaceAutoCompleteModel.fromJson(e))
            .toList(),
      );
    } catch (e) {
      return BaseResponseModel(
        code: 400,
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> placesDetail() async {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponseModel<GeocodeModel>> geocoding({
    String? address,
    String? placeId,
  }) async {
    final res = await _dio.dio().get(
        '${Api.urlGMS}/geocode/json?key=${PrefKeys.GMSToken}${address != null ? '&address=$address' : ''}${placeId != null ? '&place_id=$placeId' : ''}');
    try {
      return BaseResponseModel(
        code: res.statusCode,
        data: GeocodeModel.fromJson(res.data['results'][0]),
      );
    } catch (e) {
      return BaseResponseModel(
        code: 400,
        message: e.toString(),
      );
    }
  }
}
