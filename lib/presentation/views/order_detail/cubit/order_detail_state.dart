import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_entity.dart';

part 'order_detail_state.freezed.dart';

@freezed
class OrderDetailState with _$OrderDetailState {
  const factory OrderDetailState({
    @Default(null) OrderEntity? dataOrder,
    @Default(false) bool isLoading,
  }) = _OrderDetailState;
}
