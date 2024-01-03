import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/views/cart/cubit/cart_state.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/usecase/add_cart_usecase.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/usecase/delete_cart_usecase.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/usecase/get_data_cart_use_case.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  CartCubit(
    this._getDataCartUsecase,
    this._addCartUsecase,
    this._deleteCartUsecase,
  ) : super(const CartState());

  final GetDataCartUsecase _getDataCartUsecase;
  final AddCartUsecase _addCartUsecase;
  final DeleteCartUsecase _deleteCartUsecase;

  void innitialize() {
    getDataCart();
  }

  void onChangeShowSearch() {
    emit(state.copyWith(showSearch: !state.showSearch));
  }

  void onChangeSearch(String? value) {
    emit(state.copyWith(search: value));
  }

  void getDataCart() async {
    final input = GetDataCartInput();
    final res = await _getDataCartUsecase.buildUseCase(input);
    List<CartEntity> listDataCart = res.response.data ?? [];
    listDataCart = listDataCart.map((element) {
      return element.copyWith(
          selected: state.listDataCartSelected
              .where((item) => item.id == element.id)
              .toList()
              .isNotEmpty);
    }).toList();
    countPrice();
    emit(state.copyWith(
      dataCart: listDataCart,
    ));
  }

  Future<bool> onChangeQuantity({
    required CartEntity variant,
    required int value,
  }) async {
    if (value > 0) {
      final input = AddCartInput(
        variant: variant.variant!.id!,
        unit: variant.unit!.id!,
        quantity: value,
      );
      final res = await _addCartUsecase.buildUseCase(input);
      getDataCart();
      return res.response.code == 200;
    } else {
      final input = DeleteCartInput(
        variant: variant.variant!.id!,
        unit: variant.unit!.id!,
        quantity: value * (-1),
      );
      final res = await _deleteCartUsecase.buildUseCase(input);
      getDataCart();
      return res.response.code == 200;
    }
  }

  void onSelectItem({required int indexVariant, required bool value}) {
    final listDataCart = [...state.dataCart];
    listDataCart[indexVariant] =
        listDataCart[indexVariant].copyWith(selected: value);
    emit(state.copyWith(dataCart: listDataCart));
    countPrice();
  }

  void countPrice() {
    final listSelected =
        state.dataCart.where((element) => element.selected).toList();
    final totalPrice = listSelected.fold(
        0,
        (total, item) =>
            (total + (item.variant!.price!.toInt()) * (item.quantity ?? 0)));
    emit(state.copyWith(
      totalPrice: totalPrice,
      listDataCartSelected: listSelected,
    ));
  }
}
