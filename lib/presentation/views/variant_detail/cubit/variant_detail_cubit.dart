import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/usecase/add_cart_usecase.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/usecase/get_variant_detail_use_case.dart';
import 'package:pharmago_patient/presentation/views/variant_detail/cubit/variant_detail_state.dart';

@injectable
class VariantDetailCubit extends Cubit<VariantDetailState> {
  VariantDetailCubit(
    this._detailVariantUsecase,
    this._addCartUsecase,
  ) : super(const VariantDetailState());

  final GetDetailVariantUsecase _detailVariantUsecase;
  final AddCartUsecase _addCartUsecase;

  void innitialize({required String variantId}) {
    getDetailVariant(id: variantId);
  }

  void getDetailVariant({required String id}) async {
    emit(state.copyWith(isLoading: true));
    final input = GetDetailVariantInput(id: id);
    final res = await _detailVariantUsecase.buildUseCase(input);
    final variant = res.response.data;
    final List<UnitEntity> listUnits =
        variant?.units != null && variant!.units!.isNotEmpty
            ? variant.units!
            : [];
    emit(state.copyWith(
      dataVariant: variant,
      listUnits: listUnits,
      isLoading: false,
    ));
  }

  void onChangeQuantityAddCart(int quantityChange) {
    final newQuantity = state.quantityAddCart + quantityChange >= 0
        ? state.quantityAddCart + quantityChange
        : 0;
    emit(state.copyWith(quantityAddCart: newQuantity));
  }

  void onSelectUnit(int? unitId) {
    emit(state.copyWith(unitSelected: unitId));
  }

  Future<BaseResponseModel<CartEntity?>> addCart() async {
    final AddCartInput input = AddCartInput(
      variant: state.dataVariant!.id!,
      unit: state.unitSelected!,
      quantity: state.quantityAddCart,
    );
    final res = await _addCartUsecase.buildUseCase(input);
    emit(state.copyWith(
      quantityAddCart: 0,
      unitSelected: null,
    ));
    return res.response;
  }

  void buyNow() {
    if (checkQuantityVariant()) {
      emit(state.copyWith(
        quantityAddCart: 0,
        unitSelected: null,
      ));
    }
  }

  bool checkQuantityVariant() {
    final bool check;
    check = state.quantityAddCart > 0 && state.unitSelected != null;
    return check;
  }
}
