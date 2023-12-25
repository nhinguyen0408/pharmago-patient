import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/product_entity.dart';
part 'drugstore_detail_state.freezed.dart';

@freezed
class DrugstoreDetailState with _$DrugstoreDetailState {
  const factory DrugstoreDetailState({
    @Default([]) List<ProductEntity> listProducts,
    @Default(null) DrugstoreEntity? dataDrugstore,
    @Default('') String? keySearchVariant,
  }) = _DrugstoreDetailState;
}
