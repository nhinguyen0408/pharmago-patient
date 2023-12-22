import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/base/dialog_custom.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/persional/cubit/persional_state.dart';
import 'package:pharmago_patient/shared/constants/pref_key.dart';
import 'package:pharmago_patient/shared/constants/storage/shared_preference.dart';

@injectable
class PersionalCubit extends Cubit<PersionalState> {
  PersionalCubit() : super(const PersionalState());

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
