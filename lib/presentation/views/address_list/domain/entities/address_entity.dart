
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/address_model.dart';
part 'address_entity.freezed.dart';

@freezed
class AddressEntity with _$AddressEntity {
  const factory AddressEntity({
    int? id,
    TitleModel? province,
    TitleModel? district,
    TitleModel? ward,
    String? fullName,
    String? phone,
    bool? isDefault,
    String? title,
    int? lat,
    int? long,
    String? createdAt,
    String? updatedAt,
    int? account,
  }) = _AddressEntity;
}