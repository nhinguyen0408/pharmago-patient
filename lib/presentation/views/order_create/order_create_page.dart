import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/base/button.dart';
import 'package:pharmago_patient/presentation/base/text_field.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore/widgets/drugstore_card.dart';
import 'package:pharmago_patient/presentation/views/order_create/cubit/order_create_cubit.dart';
import 'package:pharmago_patient/presentation/views/order_create/cubit/order_create_state.dart';
import 'package:pharmago_patient/presentation/views/order_create/widgets/variant_create_order_card.dart';
import 'package:pharmago_patient/shared/utils/dialog_utils.dart';
import 'package:pharmago_patient/shared/utils/event.dart';
import 'package:pharmago_patient/shared/views/empty_container.dart';

@RoutePage()
class OrderCreatePage extends StatefulWidget {
  const OrderCreatePage(
      {super.key,
      required this.dataCart,
      this.canChangeQuantity = false,
      required this.drugstore});
  final List<CartEntity> dataCart;
  final bool canChangeQuantity;
  final DrugstoreEntity drugstore;

  @override
  State<OrderCreatePage> createState() => _OrderCreatePageState();
}

class _OrderCreatePageState extends State<OrderCreatePage> {
  final bloc = getIt.get<OrderCreateCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderCreateCubit>(
      create: (context) => bloc..innitialize(dataCart: widget.dataCart),
      child: BlocBuilder<OrderCreateCubit, OrderCreateState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: bg_5,
              body: SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        width: widthDevice(context),
                        padding: const EdgeInsets.all(sp16),
                        child: Column(
                          children: [
                            const SizedBox(height: 60),
                            BaseContainer(
                              context,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        state.userAddressDefault?.fullName ?? '',
                                        style: h5,
                                      ),
                                      const Spacer(),
                                      Text(
                                        state.userAddressDefault?.phone ?? '',
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
                                  AppInputSupport(
                                    hintText: 'Nhập triệu chứng...',
                                    validate: (value) {},
                                    initialValue: state.note,
                                    onChanged: bloc.changeNote,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: sp16,
                            ),
                            BaseContainer(
                              context,
                              ExpandablePanel(
                                theme: const ExpandableThemeData(
                                    iconColor: greyColor),
                                header: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: sp8),
                                  child: const Text(
                                    'Địa chỉ nhận hàng',
                                    style: p6,
                                  ),
                                ),
                                collapsed: const SizedBox(),
                                expanded: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    state.userAddressDefault?.title ?? '',
                                    style: h5,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: sp16,
                            ),
                            BaseContainer(
                              context,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final item = state.orderItems[index];
                                      return Column(
                                        children: [
                                          DrugstoreCard(
                                              data: item.drugstore!,
                                              canClick: false),
                                          const SizedBox(height: sp16),
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (contex, indexOrderItem) {
                                              final itemVariant =
                                                  item.orderItems[indexOrderItem];
                                              return VariantCreateOrderCard(
                                                dataVariant: itemVariant,
                                                onChangeQuantity: (int i) {
                                                  bloc.onChangeQuantityItem(index, indexOrderItem, i);
                                                },
                                                canChangeQuantity:
                                                    widget.canChangeQuantity,
                                              );
                                            },
                                            separatorBuilder: (contex, indexOrderItem) {
                                              return const SizedBox(
                                                height: sp8,
                                              );
                                            },
                                            itemCount: item.orderItems.length,
                                          ),
                                          const SizedBox(
                                            height: sp16,
                                          ),
                                          Row(
                                            children: [
                                              const Text('Tổng tiền'),
                                              const Spacer(),
                                              Text(
                                                FormatCurrency(item.totalPrice),
                                                style:
                                                    h5.copyWith(color: mainColor),
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
                                    itemCount: state.orderItems.length,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: sp16,
                            ),
                            BaseContainer(
                              context,
                              ExpandablePanel(
                                theme: const ExpandableThemeData(
                                    iconColor: greyColor),
                                header: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: sp8),
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
                                collapsed: const SizedBox(),
                                expanded: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(sp16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(sp8),
                                    color: bg_6,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                            FormatCurrency(state.totalPrice),
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
                                            FormatCurrency(state.totalPrice),
                                            style: h6.copyWith(color: mainColor),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
                                const Text('Đặt hàng', style: h5),
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
              bottomNavigationBar: Container(
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
                          'Tổng (${widget.dataCart.length} sản phẩm)',
                          style: p5.copyWith(color: greyColor),
                        ),
                        const Spacer(),
                        Text(
                          '${FormatCurrency(state.totalPrice)} VNĐ',
                          style: p3,
                        ),
                      ],
                    ),
                    const SizedBox(height: sp16),
                    SizedBox(
                      width: double.infinity,
                      child: MainButton(
                        title: 'Đặt hàng',
                        event: () {
                          _buyNow(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _buyNow(BuildContext context) async {
    if (bloc.state.userAddressDefault?.id == null) {
      return;
    } else {
      DialogUtils.showLoadingDialog(
        context,
        content: 'Đang thêm vào giỏ hàng',
      );
      final res = await bloc.createOrder();
      Navigator.of(context).pop();
      if (res && context.mounted) {
        DialogUtils.showSuccessDialog(
          context,
          barrierDismissible: false,
          content: 'Thêm sản phẩm vào giỏ hàng thành công',
          titleConfirm: 'Xem danh sách',
          titleClose: 'Quay lại',
          accept: () {
            Navigator.of(context).pop();
            context.router.replace(const OrderListRoute());
          },
          close: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      } else {
        // ignore: use_build_context_synchronously
        DialogUtils.showErrorDialog(
          context,
          content: 'Tạo đơn thất bại',
        );
      }
    }
  }
}
