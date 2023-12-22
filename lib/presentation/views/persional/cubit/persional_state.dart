import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/entities/persional_profile_entity.dart';
part 'persional_state.freezed.dart';

@freezed
class PersionalState with _$PersionalState {
  const factory PersionalState({
    @Default(null) PersionalProfileEntity? dataPersional,
  }) = _PersionalState;
}
