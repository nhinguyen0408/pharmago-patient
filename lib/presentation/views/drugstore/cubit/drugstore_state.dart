import 'package:freezed_annotation/freezed_annotation.dart';
part 'drugstore_state.freezed.dart';

@freezed
class DrugstoreState with _$DrugstoreState {
  const factory DrugstoreState({
    @Default(false) bool showSearch,
    @Default('') String? search,
    
  }) = _DrugstoreState;
}
