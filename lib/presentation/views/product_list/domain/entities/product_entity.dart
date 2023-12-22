import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';

@freezed
class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    int? id,
    String? title,
    String? code,
    int? workspace,
    String? image,
    String? description,
    dynamic brand,
    dynamic category,
    dynamic productType,
    dynamic productAttributes,
    dynamic createdBy,
    DateTime? timeCreated,
    DateTime? timeUpdated,
    bool? imported,
  }) = _ProductEntity;
}