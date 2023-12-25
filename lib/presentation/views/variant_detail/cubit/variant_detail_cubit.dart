import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/usecase/get_variant_detail_use_case.dart';
import 'package:pharmago_patient/presentation/views/variant_detail/cubit/variant_detail_state.dart';
import 'package:pharmago_patient/shared/utils/dialog_utils.dart';

@injectable
class VariantDetailCubit extends Cubit<VariantDetailState> {
  VariantDetailCubit(this._detailVariantUsecase)
      : super(const VariantDetailState());

  final GetDetailVariantUsecase _detailVariantUsecase;

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

  void addCart(BuildContext context) {
    if (checkQuantityVariant(context)) {
      Navigator.pop(context);
      DialogUtils.showSuccessDialog(
        context,
        barrierDismissible: false,
        content: 'Thêm sản phẩm vào giỏ hàng thành công',
        titleConfirm: 'OK',
        accept: () {
          Navigator.pop(context);
        },
      );
      emit(state.copyWith(
        quantityAddCart: 0,
        unitSelected: null,
      ));

    }
  }

  void buyNow(BuildContext context) {
    if (checkQuantityVariant(context)) {
      Navigator.pop(context);
      emit(state.copyWith(
        quantityAddCart: 0,
        unitSelected: null,
      ));
    }
  }

  bool checkQuantityVariant(BuildContext context) {
    final bool check;
    check = state.quantityAddCart > 0 && state.unitSelected != null;
    if (!check) {
      DialogUtils.showErrorDialog(
        context,
        content: 'Vui lòng chọn số lượng và đơn vị',
      );
    }
    return check;
  }
}
