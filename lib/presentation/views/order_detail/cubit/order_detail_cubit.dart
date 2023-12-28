import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/views/order_detail/cubit/order_detail_state.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/usecase/get_detail_order_use_case.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/usecase/update_status_order_use_case.dart';

@injectable
class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit(this._getDetailOrderUsecase, this._updateStatusOrderUsecase)
      : super(const OrderDetailState());
  final GetDetailOrderUsecase _getDetailOrderUsecase;
  final UpdateStatusOrderUsecase _updateStatusOrderUsecase;

  void innitialize(int id) {
    getDetailOrder(id: id);
  }

  Future<void> getDetailOrder({required int id}) async {
    emit(state.copyWith(isLoading: true));
    final input = GetDetailOrderInput(id: id.toString());
    final res = await _getDetailOrderUsecase.execute(input);
    if (res.response.code == 200) {
      emit(state.copyWith(
        dataOrder: res.response.data,
        isLoading: false,
      ));
    }
  }


  Future<bool> updateStatus({required int id, required StatusOrder status}) async {
    final input = UpdateStatusOrderInput(id: id.toString(), status: status);
    final res = await _updateStatusOrderUsecase.execute(input);
    return res.response.code == 200;
  }
}
