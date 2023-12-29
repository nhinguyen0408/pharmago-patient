import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/location_entity.dart';

part 'address_state.freezed.dart';

@freezed
class AddressState with _$AddressState {
  const factory AddressState({
    @Default(false) bool isLoadingComplete,
    @Default(true) bool isLoading,
    @Default(<LocationEntity>[]) List<LocationEntity> listAddress,
    String? province,
    String? district,
    String? ward,
    @Default(1) int provinceId,
    @Default(1) int districtId,
    @Default(1) int wardId,
    String? street,
    String? title,
    double? heightBottomSheet,
    @Default('') String citySearch,
    @Default('') String districtSearch,
    @Default('') String wardsSearch,
  }) = _AddressState;
}
