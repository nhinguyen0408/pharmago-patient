import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
part 'cart_entity.freezed.dart';

@freezed
class CartEntity with _$CartEntity {
  const CartEntity._();

  const factory CartEntity({
    int? id,
    int? quantity,
    UnitEntity? unit,
    VariantEntity? variant,
    @Default(false) bool selected,
  }) = _CartEntity;
}