import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
part 'variant_detail_state.freezed.dart';

@freezed
class VariantDetailState with _$VariantDetailState {
  const factory VariantDetailState({
    @Default(null) VariantEntity? dataVariant,
    @Default(false) bool isLoading,
    @Default(0) int quantityAddCart,
    @Default([]) List<UnitEntity> listUnits,
    @Default(null) int? unitSelected,
  }) = _VariantDetailState;
}
