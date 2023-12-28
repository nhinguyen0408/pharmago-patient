import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/base/infinite_list.dart';
import 'package:pharmago_patient/presentation/views/order_list/cubit/order_list_state.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/usecase/get_list_order_use_case.dart';

@injectable
class OrderListCubit extends Cubit<OrderListState> {
  OrderListCubit(this._getListOrderUsecase) : super(const OrderListState());

  final GetListOrderUsecase _getListOrderUsecase;

  final ScrollController scrollController = ScrollController();
  final InfiniteListController<OrderEntity> infiniteListController = InfiniteListController<OrderEntity>.init();

  void innitialize () {
  }

  void onChangeSearch(String val) {
    emit(state.copyWith(search: val));
    infiniteListController.onRefresh();
  }

  Future<List<OrderEntity>> getListOrders ({ required int page, required StatusOrder status }) async {
    final input = GetListOrderInput(page: page, limit: 10, status: status, search: state.search,);
    final res = await _getListOrderUsecase.execute(input);
    return res.response.data ?? [];
  }
}
