import 'package:freezed_annotation/freezed_annotation.dart';
part 'variant_entity.freezed.dart';

@freezed
class VariantEntity with _$VariantEntity {
  const factory VariantEntity({
    int? id,
    double? capitalPrice,
    double? price,
    dynamic sku,
    String? image,
    String? title,
    String? description,
    bool? active,
    List<UnitEntity>? units,
    dynamic addition,
  }) = _VariantEntity;
}


@freezed
class UnitEntity with _$UnitEntity {
  const factory UnitEntity({
    int? id,
    String? timeCreated,
    String? timeUpdated,
    String? title,
    double? capitalPrice,
    double? price,
    int? weight,
    dynamic weightUnit,
    bool? classic,
    dynamic createdBy,
    dynamic updatedBy,
  }) = _UnitEntity;
}