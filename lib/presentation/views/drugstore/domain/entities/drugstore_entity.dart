import 'package:freezed_annotation/freezed_annotation.dart';

part 'drugstore_entity.freezed.dart';

@freezed
class DrugstoreEntity with _$DrugstoreEntity {
  const factory DrugstoreEntity({
    int? id,
    String? code,
    String? name,
    String? address,
    DateTime? timeCreated,
    DateTime? timeUpdated,
    dynamic createdBy,
    dynamic updatedBy,
    double? lat,
    double? long,
  }) = _DrugstoreEntity;
}