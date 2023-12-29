import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/base/button.dart';
import 'package:pharmago_patient/presentation/base/loading.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/address_list/cubit/address_list_cubit.dart';
import 'package:pharmago_patient/presentation/views/address_list/cubit/address_list_state.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';
import 'package:pharmago_patient/presentation/views/address_list/widget/address_card.dart';
import 'package:pharmago_patient/shared/utils/dialog_utils.dart';
import 'package:pharmago_patient/shared/views/empty_container.dart';

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
                  state.isLoading
                      ? const BaseLoading()
                      : RefreshIndicator(
                          onRefresh: () async {
                            bloc.getListAddress();
                          },
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Container(
                              width: widthDevice(context),
                              padding: const EdgeInsets.all(sp16),
                              child: Column(
                                children: [
                                  const SizedBox(height: 60),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = state.listAddress[index];
                                      return AddressCard(
                                        data: item,
                                        onHandelLeft: () {
                                          _setAddressDefault(context, item);
                                        },
                                        onHandelRight: () {
                                          context.router.push(
                                            AddressCreateRoute(
                                              addressListCubit: bloc,
                                              data: item,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(height: sp16);
                                    },
                                    itemCount: state.listAddress.length,
                                  ),
                                  const SizedBox(height: 16),
                                  BaseContainer(
                                    context,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Địa chỉ giao hàng (${state.listAddress.length})',
                                          style: h5,
                                        ),
                                        const SizedBox(
                                          height: sp4,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            state.listAddress.isEmpty
                                                ? 'Không có địa chỉ giao hàng nào đã đăng ký. Bắt buộc đăng ký tên, địa chỉ và số điện thoại đối với đơn đặt trực tuyến'
                                                : 'Có thể lưu tối đa 10 địa chỉ',
                                            style:
                                                p6.copyWith(color: greyColor),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: sp8,
                                        ),
                                        Visibility(
                                          visible:
                                              state.listAddress.length < 10,
                                          child: Row(
                                            children: [
                                              const Spacer(),
                                              SizedBox(
                                                width: 130,
                                                child: MainButton(
                                                  event: () {
                                                    context.router.push(
                                                        AddressCreateRoute(
                                                            addressListCubit:
                                                                bloc));
                                                  },
                                                  largeButton: false,
                                                  title:
                                                      state.listAddress.isEmpty
                                                          ? 'Đăng ký địa chỉ'
                                                          : 'Thêm địa chỉ',
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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

  void _setAddressDefault(
    BuildContext context,
    AddressEntity address,
  ) async {
    DialogUtils.showLoadingDialog(
      context,
      content: 'Đang đặt mặc định',
    );
    final res = await bloc.setDefaultAddress(address: address);
    Navigator.of(context).pop();
    if (!res) {
      // ignore: use_build_context_synchronously
      DialogUtils.showErrorDialog(
        context,
        content: 'Đặt mặc định thất bại !',
      );
    } else {
      bloc.getListAddress();
    }
  }
}
