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
    bool? active,
    List<dynamic>? units,
    dynamic addition,
  }) = _VariantEntity;
}