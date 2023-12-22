import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/base/app_bar.dart';
import 'package:pharmago_patient/presentation/base/button.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/views/persional/cubit/persional_cubit.dart';

@RoutePage()
class PersionalPage extends StatefulWidget {
  const PersionalPage({super.key});

  @override
  State<PersionalPage> createState() => _PersionalPageState();
}

class _PersionalPageState extends State<PersionalPage> {
  final myBloc = getIt.get<PersionalCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersionalCubit>(
      create: (contex) => myBloc,
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: true,
        appBar: const BaseAppBar(
          title: 'Thông tin cá nhân',
        ),
        body: Container(
          width: widthDevice(context),
          padding: const EdgeInsets.all(sp16),
          child: MainButton(
            title: 'Đăng xuất',
            event: () => myBloc.logout(context),
          ),
        ),
      ),
    );
  }
}
