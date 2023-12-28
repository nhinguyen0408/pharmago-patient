import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/entities/persional_profile_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_count_entity.dart';
part 'persional_state.freezed.dart';

@freezed
class PersionalState with _$PersionalState {
  const factory PersionalState({
    @Default(null) PersionalProfileEntity? dataPersional,
    @Default([]) List<CountOrderEntity> listCountOrderByStatus,
    @Default(false) bool errorCountOrder,
  }) = _PersionalState;
}
