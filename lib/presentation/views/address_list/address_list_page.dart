import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/views/address_list/cubit/address_list_cubit.dart';
import 'package:pharmago_patient/presentation/views/address_list/cubit/address_list_state.dart';
import 'package:pharmago_patient/presentation/views/address_list/widget/address_card.dart';

@RoutePage()
class AddressListPage extends StatefulWidget {
  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  final bloc = getIt.get<AddressListCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressListCubit>(
      create: (context) => bloc..innitialize(),
      child: BlocBuilder<AddressListCubit, AddressListState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: bg_5,
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: heightDevice(context),
                      width: widthDevice(context),
                      padding: const EdgeInsets.all(sp16),
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final item = state.listAddress[index];
                              return AddressCard(
                                data: item,
                                onHandel: () {},
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(height: sp16);
                            },
                            itemCount: state.listAddress.length,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(sp16),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: borderColor_2,
                            width: 1.0,
                          ),
                        ),
                        color: whiteColor,
                      ),
                      width: widthDevice(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.chevron_left,
                                  color: blackColor,
                                ),
                              ),
                              const SizedBox(width: sp8),
                              const Text('Địa chỉ', style: h5),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}