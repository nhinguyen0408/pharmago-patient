import 'package:json_annotation/json_annotation.dart';
part 'variant_still_in_stock_entity.g.dart';

@JsonSerializable()
class VariantStillInStockEntity {
  VariantStillInStockEntity(this.variantId, this.unit, {this.count = 0});

  @JsonKey(name: 'variant')
  int? variantId;
  @JsonKey(name: 'count')
  int count;
  @JsonKey(name: 'unit')
  int unit;

  factory VariantStillInStockEntity.fromJson(Map<String, dynamic> json) =>
      _$VariantStillInStockEntityFromJson(json);
  Map<String, dynamic> toJson() => _$VariantStillInStockEntityToJson(this);
}

@JsonSerializable()
class VariantCheckInStockEntity {
  VariantCheckInStockEntity({
    this.id,
    this.unit,
  });

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'unit')
  int? unit;

  factory VariantCheckInStockEntity.fromJson(Map<String, dynamic> json) =>
      _$VariantCheckInStockEntityFromJson(json);
  Map<String, dynamic> toJson() => _$VariantCheckInStockEntityToJson(this);
}
