import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/base/dialog_custom.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_count_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/usecase/count_order_use_case.dart';
import 'package:pharmago_patient/presentation/views/persional/cubit/persional_state.dart';
import 'package:pharmago_patient/shared/constants/pref_key.dart';
import 'package:pharmago_patient/shared/constants/storage/shared_preference.dart';

@injectable
class PersionalCubit extends Cubit<PersionalState> {
  PersionalCubit(this._countOrderUsecase) : super(const PersionalState());

  final CountOrderUsecase _countOrderUsecase;

  void innitialize() {
    countOrder();
  }

  Future<void> countOrder() async {
    final input = CountOrderInput();
    final res = await _countOrderUsecase.execute(input);
    if (res.response.code == 200) {
      final List<CountOrderEntity> data = res.response.data ?? [];
      emit(state.copyWith(
        listCountOrderByStatus: data,
        errorCountOrder: false,
      ));
    } else {
      emit(state.copyWith(errorCountOrder: true));
    }
  }

  void logout(BuildContext context) {
    DialogCustoms.showNotifyDialog(
      context,
      content: const Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: Text('Bạn có muốn thoát khỏi ứng dụng không?'),
      ),
      click: () async {
        await AppSharedPreference.instance.remove(PrefKeys.token);
        await AppSharedPreference.instance.remove(PrefKeys.user);
        await AppSharedPreference.instance.remove(PrefKeys.username);

        context.router.pushAndPopUntil(
          const LoginRoute(),
          predicate: (Route<dynamic> route) => false,
        );
      },
    );
  }
}
