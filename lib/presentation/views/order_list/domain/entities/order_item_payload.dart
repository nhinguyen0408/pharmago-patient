
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
part 'order_item_payload.freezed.dart';
@freezed
class OrderItemPayload with _$OrderItemPayload {
  const factory OrderItemPayload({
    String? note,
    int? workspace,
    @Default([]) List<CartEntity> cartItems,
  }) = _OrderItemPayload;
}