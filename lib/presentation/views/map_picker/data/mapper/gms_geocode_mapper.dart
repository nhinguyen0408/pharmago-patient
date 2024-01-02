import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/mapper/base/data_mapper.dart';
import 'package:pharmago_patient/presentation/views/map_picker/data/models/gms_model/geocode_model.dart';
import 'package:pharmago_patient/presentation/views/map_picker/domain/entities/gms_geocode_entity.dart';

@injectable
class GMSGeocodeEntityMapper
    extends BaseDataMapper<GeocodeModel, GMSGeocodeEntity> {
  @override
  GMSGeocodeEntity mapToEntity(GeocodeModel? data) {
    return GMSGeocodeEntity(
      lat: data?.geometry?.location?.lat,
      lng: data?.geometry?.location?.lng,
      addressName: data?.formattedAddress,
      addressComponent: data?.formattedAddress?.split(',')
          .map(
            (e) => AddressComponentEntity(
              value: e,
            ),
          )
          .toList().reversed.toList(),
    );
  }
}
