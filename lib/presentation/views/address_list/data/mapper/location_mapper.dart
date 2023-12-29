
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/mapper/base/data_mapper.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/location_model.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/location_entity.dart';

@injectable
class LocationMapper extends BaseDataMapper<LocationModel, LocationEntity> {
  @override
  LocationEntity mapToEntity(LocationModel? data) {
    return LocationEntity(
      id: data?.id,
      code: data?.code,
      title: data?.title,
    );
  }

}