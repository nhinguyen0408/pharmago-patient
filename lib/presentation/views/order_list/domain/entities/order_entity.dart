import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/models/order_model.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_count_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
part 'order_entity.freezed.dart';

@freezed
class OrderEntity with _$OrderEntity {
  const factory OrderEntity({
    int? id,
    String? code,
    DrugstoreEntity? workspace,
    int? address,
    AddressEntity? addressData,
    int? account,
    int? totalItem,
    double? totalCost,
    List<OrderItemEntity>? items,
    String? note,
    CountOrderEntity? status,
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