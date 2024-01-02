import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/location_entity.dart';
import 'package:pharmago_patient/presentation/views/map_picker/domain/entities/gms_geocode_entity.dart';
import 'package:pharmago_patient/presentation/views/map_picker/domain/entities/gms_places_auto_complete_entity.dart';

import '../map_picker_page.dart';
part 'map_picker_state.freezed.dart';


@freezed
class MapPickerState with _$MapPickerState {
  const factory MapPickerState({
    @Default(null) AddressPickerEntity? addressInit,
    @Default(<Marker>{}) Set<Marker> markers,
    @Default(LatLng(21.028227869189582, 105.85217546813503)) LatLng myLocation,
    @Default(true) bool isLoading,
    @Default('') String addressSearch,
    @Default([]) List<GMSPlaceAutoCompleteEntity> listPlaceSearch,
    @Default(null) GMSGeocodeEntity? locationPicked,
    @Default(null) LocationEntity? province,
    @Default(null) LocationEntity? district,
    @Default(null) LocationEntity? ward,
    @Default('') String addressTitle,
    @Default(null) LatLng? latLng,
  }) = _MapPickerState;
}
