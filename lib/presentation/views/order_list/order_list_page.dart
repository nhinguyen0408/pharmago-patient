import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/base/infinite_list.dart';
import 'package:pharmago_patient/presentation/base/loading.dart';
import 'package:pharmago_patient/presentation/base/text_field.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/views/order_list/cubit/order_list_cubit.dart';
import 'package:pharmago_patient/presentation/views/order_list/cubit/order_list_state.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';
import 'package:pharmago_patient/presentation/views/order_list/widgets/order_card.dart';
import 'package:pharmago_patient/presentation/views/persional/cubit/persional_cubit.dart';

@RoutePage()
class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key, required this.status, this.persionalCubit});

  final StatusOrder status;
  final PersionalCubit? persionalCubit;

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final bloc = getIt.get<OrderListCubit>();

  String getName(StatusOrder status) {
    switch (status) {
      case StatusOrder.NEW:
        return 'Chờ xác nhận';
      case StatusOrder.TRANSPORT:
        return 'Đã xác nhận';
      case StatusOrder.COMPLETE:
        return 'Hoàn thành';
      case StatusOrder.CANCEL:
        return 'Đã huỷ';
      default:
        return 'Chờ xác nhận';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderListCubit>(
      create: (context) => bloc..innitialize(),
      child: BlocBuilder<OrderListCubit, OrderListState>(
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
                            bloc.infiniteListController.onRefresh();
                          },
                          child: SingleChildScrollView(
                            controller: bloc.scrollController,
                            child: Container(
                              width: widthDevice(context),
                              padding: const EdgeInsets.all(sp16),
                              child: Column(
                                children: [
                                  const SizedBox(height: 60),
                                  AppInputSupport(
                                    hintText: 'Tìm kiếm',
                                    validate: (value) {},
                                    onConfirm: bloc.onChangeSearch,
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: blackColor,
                                      size: 20,
                                    ),
                                    initialValue: state.search,
                                    borderColor: borderColor_2,
                                    backgroundColor: whiteColor,
                                  ),
                                  const SizedBox(height: sp16),
                                  InfiniteList(
                                    shrinkWrap: true,
                                    getData: (int page) {
                                      return bloc.getListOrders(
                                          page: page + 1,
                                          status: widget.status);
                                    },
                                    itemBuilder: (context, item, index) {
                                      return OrderCard(
                                        status: widget.status,
                                        data: item,
                                        onUpdateSuccess: () {
                                          bloc.infiniteListController
                                              .onRefresh();
                                          if (widget.persionalCubit != null)
                                            widget.persionalCubit!.countOrder();
                                        },
                                      );
                                    },
                                    scrollController: bloc.scrollController,
                                    infiniteListController:
                                        bloc.infiniteListController,
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
                              Text(getName(widget.status), style: h5),
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
