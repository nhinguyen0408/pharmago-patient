import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';

part 'address_list_state.freezed.dart';

@freezed
class AddressListState with _$AddressListState {
  const factory AddressListState({
    @Default([]) List<AddressEntity> listAddress,
    @Default(false) bool isLoading,
  }) = _AddressListState;
}
