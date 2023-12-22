import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/base/bottom_bar.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/views/drugstore/drugstore_page.dart';
import 'package:pharmago_patient/presentation/views/health_record/health_record_page.dart';
import 'package:pharmago_patient/presentation/views/home/cubit/home_cubit.dart';
import 'package:pharmago_patient/presentation/views/home/cubit/home_state.dart';
import 'package:pharmago_patient/presentation/views/home/widgets/persional_information_card.dart';
import 'package:pharmago_patient/presentation/views/persional/persional_page.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myBloc = getIt.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => myBloc..ininttialize(),
      child: Scaffold(
        backgroundColor: accentColor_4,
        body: Container(
          width: widthDevice(context),
          height: heightDevice(context),
          color: blue_2,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              switch (state.pageSelected) {
                case TabCode.home:
                  return Home(homeCubit: myBloc);
                case TabCode.health:
                  return const HealthRecordPage();
                case TabCode.drugstore:
                  return const DrugstorePage();
                case TabCode.persional:
                  return const PersionalPage();
                default:
                  return Home(homeCubit: myBloc);
              }
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return BuildBottomBar(
              pageCode: state.pageSelected,
              onTap: myBloc.onPageChange,
            );
          },
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.homeCubit});
  final HomeCubit homeCubit;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_5,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child:
                  PersionalHomeCard(dataUser: widget.homeCubit.state.dataUser),
            ),
            Container(
              height: heightDevice(context),
              width: widthDevice(context),
              padding: const EdgeInsets.all(sp16),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Row(
                    children: [
                      const Text('Nhà thuốc gần đây', style: p3),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Xem tất cả',
                          style: p5.copyWith(color: mainColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
