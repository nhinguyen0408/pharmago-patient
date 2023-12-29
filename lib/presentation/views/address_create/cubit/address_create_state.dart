import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/payload/address_payload_model.dart';

part 'address_create_state.freezed.dart';
@freezed
class AddressCreateState with _$AddressCreateState {
  const factory AddressCreateState({
    @Default('') String fullname,
    @Default('') String phone,
    @Default('') String addressTitle,
    @Default(false) bool isDefaultAddress,
     @Default(null) AddressPayloadModel? addressPayload,
     @Default(null) int? idAddress,
  }) = _AddressCreateState;
}
