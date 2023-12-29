import 'package:pharmago_patient/presentation/views/address_list/data/models/location_model.dart';

abstract class LocationRepository {
  Future<List<LocationModel>> getListProvince();
  Future<List<LocationModel>> getListDistrict(int? id);
  Future<List<LocationModel>> getListWard(int? id);
}
