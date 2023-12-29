import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/usecase/get_list_address_use_case.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/order_create/cubit/order_create_state.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_item_payload.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/usecase/create_order_use_case.dart';

@injectable
class OrderCreateCubit extends Cubit<OrderCreateState> {
  OrderCreateCubit(
    this._getListAddressUsecase,
    this._createOrderUsecase,
  ) : super(const OrderCreateState());
  final GetListAddressUsecase _getListAddressUsecase;
  final CreateOrderUsecase _createOrderUsecase;

  void innitialize({required List<CartEntity> dataCart}) {
    List<OrderItemForCreateOrderType> orderItem = [];
    dataCart.forEach((item) {
      if (item.drugstore != null) {
        final existIndex = orderItem.indexWhere(
            (element) => element.drugstore?.id == item.drugstore!.id);
        if (existIndex != -1) {
          List<CartEntity> items = [...orderItem[existIndex].orderItems];
          items.add(item);
          orderItem[existIndex] = orderItem[existIndex].copyWith(
            orderItems: items,
            totalPrice: countPrice(items),
          );
        } else {
          List<CartEntity> list = [];
          list.add(item);
          final newItem = OrderItemForCreateOrderType(
            drugstore: item.drugstore,
            orderItems: list,
            totalPrice: countPrice(list),
          );
          orderItem.add(newItem);
        }
      }
    });
    final totalPrice = countPrice(dataCart);
    emit(state.copyWith(
      orderItems: orderItem,
      totalPrice: totalPrice,
    ));
    getListAddress();
  }

  changeNote(String value) {
    emit(state.copyWith(note: value));
  }

  onChangeQuantityItem(int indexOrderItem, int indexVariant, int value) {
    final quantity =
        state.orderItems[indexOrderItem].orderItems[indexVariant].quantity;
    if (quantity != null && quantity > 1) {
      List<OrderItemForCreateOrderType> array =
          List<OrderItemForCreateOrderType>.from(state.orderItems);
      final newQuantity = quantity + value;
      CartEntity updatedItem = array[indexOrderItem]
          .orderItems[indexVariant]
          .copyWith(quantity: newQuantity);
      List<CartEntity> listVariant =
          List.from(array[indexOrderItem].orderItems);
      listVariant[indexVariant] = updatedItem;
      array[indexOrderItem] = array[indexOrderItem].copyWith(
        orderItems: listVariant,
        totalPrice: countPrice(listVariant),
      );
      final totalPrice = array.fold(0, (previousValue, element) => previousValue += element.totalPrice);
      emit(state.copyWith(
        orderItems: array,
        totalPrice: totalPrice,
      ));
    }
  }

  Future<void> getListAddress() async {
    final input = GetListAddressInput();
    final res = await _getListAddressUsecase.execute(input);
    final listData = res.response.data ?? [];
    final defaultAddress = listData
        .firstWhere((item) => item.isDefault != null && item.isDefault!);
    emit(state.copyWith(
      listAddress: listData,
      userAddressDefault: defaultAddress,
    ));
  }

  int countPrice(List<CartEntity> list) {
    final totalPrice = list.fold(
        0,
        (total, item) =>
            (total + (item.variant!.price!.toInt()) * (item.quantity ?? 0)));
    return totalPrice;
  }

  Future<bool> createOrder() async {
    final input = CreateOrderInput(
      address: state.userAddressDefault!.id!,
      orderItems: state.orderItems.map(
        (e) => OrderItemPayload(
          note: state.note,
          workspace: e.drugstore!.id,
          cartItems: e.orderItems
        )
      ).toList(),
    );

    final res = await _createOrderUsecase.execute(input);
    return res.response.code == 200;
  }
}
