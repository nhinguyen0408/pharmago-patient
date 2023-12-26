import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/base/app_bar.dart';
import 'package:pharmago_patient/presentation/base/button.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/persional/cubit/persional_cubit.dart';
import 'package:pharmago_patient/shared/views/empty_container.dart';

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
        backgroundColor: bg_5,
        resizeToAvoidBottomInset: true,
        appBar: const BaseAppBar(
          title: 'Thông tin cá nhân',
        ),
        body: Container(
          width: widthDevice(context),
          padding: const EdgeInsets.all(sp16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hồ sơ',
                style: p3,
              ),
              const SizedBox(height: sp16),
              BaseContainer(
                  context,
                  Column(
                    children: [
                      InkWell(
                        onTap: () =>
                            context.router.push(const AddressListRoute()),
                        child: const Row(
                          children: [
                            Text(
                              'Danh sách địa chỉ',
                              style: h6,
                            ),
                            Spacer(),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: sp16),
              SizedBox(
                width: double.infinity,
                child: MainButton(
                  title: 'Đăng xuất',
                  event: () => myBloc.logout(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
