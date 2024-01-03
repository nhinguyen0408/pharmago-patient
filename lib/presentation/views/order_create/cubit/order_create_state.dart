import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/variant_still_in_stock_entity.dart';
part 'order_create_state.freezed.dart';

@freezed
class OrderCreateState with _$OrderCreateState {
  const factory OrderCreateState({
    @Default([]) List<AddressEntity> listAddress,
    @Default(null) AddressEntity? userAddressDefault,
    @Default(false) bool hasVariantOutOfStock,
    @Default(null) DrugstoreEntity? drugstore,
    @Default([]) List<OrderItemForCreateOrderType> orderItems,
    @Default(0) int totalPrice,
    @Default('') String? note,
  }) = _OrderCreateState;
}

@freezed 
class OrderItemForCreateOrderType with _$OrderItemForCreateOrderType {
   const factory OrderItemForCreateOrderType({
    @Default(null) DrugstoreEntity? drugstore,
    @Default([]) List<CartEntity> orderItems,
    @Default(0) int totalPrice,
    @Default([]) List<VariantStillInStockEntity> variantInStock,
  }) = _OrderItemForCreateOrderType;
}