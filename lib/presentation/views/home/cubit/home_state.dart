import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/base/bottom_bar.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/entities/persional_profile_entity.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  
  factory HomeState({
    @Default(TabCode.home) TabCode pageSelected,
    @Default(null) PersionalProfileEntity? dataUser,
  }) = _HomeState;
}
