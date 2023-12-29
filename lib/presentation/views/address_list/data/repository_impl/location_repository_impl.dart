import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/apis/end_point.dart';
import 'package:pharmago_patient/data/config/dio.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/location_model.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/repository/location_repository.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl extends LocationRepository {
  @override
  Future<List<LocationModel>> getListProvince() async {
    final res = await getIt.get<BaseDio>().dio().get(Api.province);
    final dataModel =
        (res.data['data'] as List).map((e) => LocationModel.fromJson(e)).toList();
    return dataModel;
  }

  @override
  Future<List<LocationModel>> getListDistrict(int? id) async {
    final res = await getIt.get<BaseDio>().dio().get('${Api.district}$id/');
    final dataModel =
        (res.data['data'] as List).map((e) => LocationModel.fromJson(e)).toList();
    return dataModel;
  }

  @override
  Future<List<LocationModel>> getListWard(int? id) async {
    final res = await getIt.get<BaseDio>().dio().get('${Api.ward}$id');
    final dataModel =
        (res.data['data'] as List).map((e) => LocationModel.fromJson(e)).toList();
    return dataModel;
  }
}