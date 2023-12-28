import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_entity.dart';
part 'order_list_state.freezed.dart';

@freezed
class OrderListState with _$OrderListState {
  const factory OrderListState({
    @Default([]) List<OrderEntity> listOrders,
    @Default(false) bool isLoading,
    @Default('') String? search,
  }) = _OrderListState;
}
