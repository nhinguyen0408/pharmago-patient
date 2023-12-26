import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default(false) bool isLoading,
    @Default(false) bool showSearch,
    @Default('') String? search,
    @Default([]) List<CartEntity> dataCart,
    @Default([]) List<CartEntity> listDataCartSelected,
    @Default(0) int totalPrice,
  }) = _CartState;
}
