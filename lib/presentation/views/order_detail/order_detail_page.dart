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
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore/widgets/drugstore_card.dart';
import 'package:pharmago_patient/presentation/views/order_detail/cubit/order_detail_cubit.dart';
import 'package:pharmago_patient/presentation/views/order_detail/cubit/order_detail_state.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';
import 'package:pharmago_patient/presentation/views/order_list/widgets/order_card.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
import 'package:pharmago_patient/shared/utils/dialog_utils.dart';
import 'package:pharmago_patient/shared/utils/event.dart';
import 'package:pharmago_patient/shared/views/empty_container.dart';

@RoutePage()
class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({
    super.key,
    required this.id,
    required this.status,
    this.onUpdateSuccess,
  });
  final int id;
  final StatusOrder status;
  final Function()? onUpdateSuccess;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final bloc = getIt.get<OrderDetailCubit>();

  StatusOrder getStatus(int status) {
    if (status == StatusOrder.NEW.getValue) {
      return StatusOrder.NEW;
    }
    if (status == StatusOrder.TRANSPORT.getValue) {
      return StatusOrder.TRANSPORT;
    }
    if (status == StatusOrder.COMPLETE.getValue) {
      return StatusOrder.COMPLETE;
    }
    if (status == StatusOrder.CANCEL.getValue) {
      return StatusOrder.CANCEL;
    }
    return StatusOrder.NEW;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderDetailCubit>(
      create: (context) => bloc..innitialize(widget.id),
      child: BlocBuilder<OrderDetailCubit, OrderDetailState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: bg_5,
              body: SafeArea(
                child: Stack(
                  children: [
                    state.isLoading
                        ? const BaseLoading()
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Container(
                              width: widthDevice(context),
                              padding: const EdgeInsets.all(sp16),
                              child: Column(
                                children: [
                                  const SizedBox(height: 60),
                                  BaseContainer(
                                    context,
                                    Row(
                                      children: [
                                        Text(
                                          state.dataOrder?.code ?? '',
                                          style: p5,
                                        ),
                                        const Spacer(),
                                        StatusOrderCart(
                                          status: getStatus(
                                              state.dataOrder?.status?.key ??
                                                  0),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: sp16,
                                  ),
                                  Visibility(
                                    visible: state.dataOrder?.workspace != null,
                                    child: DrugstoreCard(
                                        data: state.dataOrder!.workspace!),
                                  ),
                                  const SizedBox(
                                    height: sp16,
                                  ),
                                  BaseContainer(
                                    context,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Thông tin người nhận',
                                          style: p6,
                                        ),
                                        const SizedBox(
                                          height: sp8,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              state.dataOrder?.addressData
                                                      ?.fullName ??
                                                  'Chưa cập nhật',
                                              style: h5,
                                            ),
                                            const Spacer(),
                                            Text(
                                              state.dataOrder?.addressData
                                                      ?.phone ??
                                                  'Chưa cập nhật',
                                              style: h5,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: sp8,
                                        ),
                                        const Text(
                                          'Ghi chú',
                                          style: p6,
                                        ),
                                        const SizedBox(
                                          height: sp4,
                                        ),
                                        Text(
                                          state.dataOrder?.note ??
                                              'Không có ghi chú',
                                          style: h5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: sp16,
                                  ),
                                  BaseContainer(
                                    context,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: sp8),
                                          child: const Text(
                                            'Địa chỉ giao hàng',
                                            style: p6,
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            state.dataOrder?.addressData
                                                    ?.title ??
                                                'Chưa cập nhật',
                                            style: h5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: sp16,
                                  ),
                                  BaseContainer(
                                    context,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sản phẩm',
                                          style: p6,
                                        ),
                                        const SizedBox(
                                          height: sp8,
                                        ),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final item =
                                                state.dataOrder?.items?[index];
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item?.variant?.title ?? '',
                                                  style: h6,
                                                ),
                                                const SizedBox(
                                                  height: sp8,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      item?.unit?.title ?? '',
                                                      style: p7.copyWith(
                                                          color: greyColor),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      '(x${item?.quantity}) ${FormatCurrency(item?.quantity != null && item?.price != null ? item!.quantity! * item.price!.toInt() : 0)}',
                                                      style: h6,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                          separatorBuilder: (contex, index) {
                                            return const SizedBox(
                                              height: sp8,
                                            );
                                          },
                                          itemCount:
                                              state.dataOrder?.items?.length ??
                                                  0,
                                        ),
                                        const SizedBox(
                                          height: sp16,
                                        ),
                                        Row(
                                          children: [
                                            const Text('Tổng tiền'),
                                            const Spacer(),
                                            Text(
                                              FormatCurrency(
                                                  state.dataOrder?.totalCost ??
                                                      0),
                                              style:
                                                  h6.copyWith(color: mainColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: sp16,
                                  ),
                                  BaseContainer(
                                    context,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: sp8),
                                          child: const Row(
                                            children: [
                                              Text(
                                                'Hình thức nhận hàng',
                                                style: p6,
                                              ),
                                              Spacer(),
                                              Text('Tại nhà', style: h6)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: sp8,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(sp16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(sp8),
                                            color: bg_6,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Text(
                                                    'Thanh toán',
                                                    style: p6,
                                                  ),
                                                  Spacer(),
                                                  Text('COD', style: h6)
                                                ],
                                              ),
                                              const SizedBox(
                                                height: sp8,
                                              ),
                                              const Divider(),
                                              const Text('Chi tiết thanh toán'),
                                              const SizedBox(
                                                height: sp8,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Tổng tiền hàng',
                                                    style: p6,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    FormatCurrency(state
                                                            .dataOrder
                                                            ?.totalCost ??
                                                        0),
                                                    style: h6,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: sp8,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Giảm giá',
                                                    style: p6,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    FormatCurrency(0),
                                                    style: h6,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: sp8,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Tổng thanh toán',
                                                    style: p6,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    FormatCurrency(state
                                                            .dataOrder
                                                            ?.totalCost ??
                                                        0),
                                                    style: h6.copyWith(
                                                        color: mainColor),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                const Text('Chi tiết đơn hàng', style: h5),
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
              bottomNavigationBar: Visibility(
                visible: state.dataOrder != null && !state.isLoading,
                child: Container(
                  padding: const EdgeInsets.all(sp16),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 16,
                            offset: Offset(0, 4),
                            color: Color.fromRGBO(0, 0, 0, 0.05)),
                      ],
                      color: whiteColor,
                      border: Border(
                        top: BorderSide(color: borderColor_2),
                      )),
                  width: widthDevice(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Tổng (${state.dataOrder?.items?.length} sản phẩm)',
                            style: p5.copyWith(color: greyColor),
                          ),
                          const Spacer(),
                          Text(
                            '${FormatCurrency(state.dataOrder?.totalCost ?? 0)} VNĐ',
                            style: p3,
                          ),
                        ],
                      ),
                      const SizedBox(height: sp16),
                      Visibility(
                        visible: getStatus(state.dataOrder?.status?.key ?? 0) ==
                            StatusOrder.NEW,
                        child: SizedBox(
                          width: double.infinity,
                          child: ExtraButton(
                            title: 'Huỷ',
                            event: () {
                              DialogUtils.showDialogWithTitleAndOptionButton(
                                context,
                                content: 'Xác nhận huỷ đơn hàng',
                                okButton: () {
                                  _updateStatusOrder(context);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: getStatus(state.dataOrder?.status?.key ?? 0) ==
                                StatusOrder.CANCEL ||
                            getStatus(state.dataOrder?.status?.key ?? 0) ==
                                StatusOrder.COMPLETE,
                        child: SizedBox(
                          width: double.infinity,
                          child: MainButton(
                            title: 'Mua lại',
                            event: () {
                              DialogUtils.showDialogWithTitleAndOptionButton(
                                context,
                                content: 'Đặt lại đơn hàng',
                                okButton: () {
                                  _buyAgain(context);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _updateStatusOrder(BuildContext context) async {
    DialogUtils.showLoadingDialog(
      context,
      content: 'Đang cập nhật trạng thái đơn vui lòng đợi',
    );
    final res =
        await bloc.updateStatus(id: widget.id, status: StatusOrder.CANCEL);
    Navigator.of(context).pop();
    if (res) {
      bloc.getDetailOrder(id: widget.id);
      if (widget.onUpdateSuccess != null) widget.onUpdateSuccess!.call();
    } else {
      DialogUtils.showErrorDialog(
        context,
        content: 'Cập nhật trạng thái thất bại',
      );
    }
  }

  void _buyAgain(BuildContext context) {
    if (bloc.state.dataOrder?.workspace != null) {
      final List<OrderItemEntity> orderItem = bloc.state.dataOrder?.items ?? [];
      List<CartEntity> dataCart = orderItem
          .map(
            (e) => CartEntity(
              quantity: e.quantity,
              unit: UnitEntity(
                id: e.unit?.id,
                title: e.unit?.title,
              ),
              variant: e.variant?.copyWith(price: e.price),
              drugstore: bloc.state.dataOrder!.workspace!,
            ),
          )
          .toList();
      context.router.push(OrderCreateRoute(
        dataCart: dataCart,
        drugstore: bloc.state.dataOrder!.workspace!,
        canChangeQuantity: true,
        isBuyAgain: true,
      ));
    } else {
      DialogUtils.showErrorDialog(
        context,
        content: 'Không tìm thấy thông tin nhà thuốc',
      );
    }
  }
}
