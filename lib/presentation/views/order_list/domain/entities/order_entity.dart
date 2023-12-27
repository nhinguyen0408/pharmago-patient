import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/models/order_model.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
part 'order_entity.freezed.dart';

@freezed
class OrderEntity with _$OrderEntity {
  const factory OrderEntity({
    int? id,
    String? code,
    int? workspace,
    int? address,
    int? account,
    int? totalItem,
    int? totalCost,
    List<OrderItemEntity>? items,
  }) = _OrderEntity;
}

@freezed
class OrderItemEntity with _$OrderItemEntity {
  const factory OrderItemEntity({
    VariantEntity? variant,
    Unit? unit,
    int? quantity,
    double? price,
  }) = _OrderItemEntity;
}