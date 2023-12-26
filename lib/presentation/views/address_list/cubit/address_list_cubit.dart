import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/views/address_list/cubit/address_list_state.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/usecase/get_list_address_use_case.dart';

@injectable
class AddressListCubit extends Cubit<AddressListState> {
  AddressListCubit(this._getListAddressUsecase)
      : super(const AddressListState());

  final GetListAddressUsecase _getListAddressUsecase;

  void innitialize() {
    getListAddress();
  }

  Future<void> getListAddress() async {
    emit(state.copyWith(isLoading: true));
    final input = GetListAddressInput();
    final res = await _getListAddressUsecase.execute(input);
    final listData = res.response.data ?? [];
    emit(state.copyWith(
      listAddress: listData,
      isLoading: false,
    ));
  }
}
