import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:pharmago_patient/presentation/base/button.dart';
import 'package:pharmago_patient/presentation/base/text_field.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/cart/cubit/cart_cubit.dart';
import 'package:pharmago_patient/presentation/views/cart/cubit/cart_state.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/cart/widgets/vartant_card_for_cart.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/shared/utils/dialog_utils.dart';
import 'package:pharmago_patient/shared/utils/event.dart';

@RoutePage()
class CartPage extends StatefulWidget {
  const CartPage({super.key, this.onChangeQuantitySuccess});

  final Function()? onChangeQuantitySuccess;
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final bloc = getIt.get<CartCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>(
      create: (context) => bloc..innitialize(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: bg_5,
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: heightDevice(context),
                    width: widthDevice(context),
                    padding: const EdgeInsets.all(sp16),
                    child: Column(
                      children: [
                        SizedBox(height: state.showSearch ? 100 : 60),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final item = state.dataCart[index];
                            return _itemSwipe(context, index, item);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: sp16);
                          },
                          itemCount: state.dataCart.length,
                        )
                      ],
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
                              const Text('Chi tiết giỏ hàng', style: h5),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  bloc.onChangeShowSearch();
                                },
                                child: state.showSearch
                                    ? const Icon(
                                        Icons.close,
                                        size: 20,
                                      )
                                    : const Icon(
                                        Icons.search,
                                        size: 20,
                                      ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: state.showSearch,
                            child: Container(
                              padding: const EdgeInsets.only(top: sp8),
                              child: AppInputSupport(
                                hintText: 'Tìm kiếm',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: blackColor,
                                  size: 20,
                                ),
                                initialValue: state.search,
                                onConfirm: bloc.onChangeSearch,
                                borderColor: borderColor_2,
                                validate: (String? value) {},
                              ),
                            ),
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
                        'Tổng (${state.listDataCartSelected.length} sản phẩm)',
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
          );
        },
      ),
    );
  }

  void _buyNow(
    BuildContext context,
  ) {
    final data = bloc.state.listDataCartSelected;
    if (data.isNotEmpty) {
      context.router.push(
          OrderCreateRoute(dataCart: data, drugstore: const DrugstoreEntity()));
    } else {
      DialogUtils.showErrorDialog(
        context,
        content: 'Vui Lòng chọn ít nhất 1 sản phẩm',
      );
    }
  }

  Widget _itemSwipe(BuildContext context, int index, CartEntity item) {
    return SwipeActionCell(
      key: ValueKey(index),
      selectedForegroundColor: Colors.black.withAlpha(30),
      trailingActions: [
        SwipeAction(
            performsFirstActionWithFullSwipe: true,
            content: Container(
              padding: const EdgeInsets.all(sp8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(sp4),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.delete_forever_rounded,
                  color: whiteColor,
                ),
              ),
            ),
            onTap: (handler) async {
              _confirmDeleteCart(context, item);
              // await handler(true);
            }),
      ],
      child: VariantCardForCart(
        dataVariant: item,
        onChangeQuantity: (int value) {
          bloc.onChangeQuantity(variant: item, value: value);
        },
        onCheckbox: (bool? value) {
          bloc.onSelectItem(indexVariant: index, value: value!);
        },
      ),
    );
  }

  Future<void> _confirmDeleteCart(BuildContext context, CartEntity cartItem) async {
    DialogUtils.showDialogWithTitleAndOptionButton(
      context,
      content: 'Xoá sản phẩm ra khỏi giỏ hàng',
      okButton: () {
        _deleteCart(context, cartItem);
      },
    );
  }

  Future<bool> _deleteCart(BuildContext context, CartEntity cartItem) async {
    DialogUtils.showLoadingDialog(
      context,
      content: 'Đang xoá sản phẩm khỏi giỏ hàng vui lòng đợi',
    );
    final res =
        await bloc.onChangeQuantity(variant: cartItem, value: - cartItem.quantity!);
    Navigator.of(context).pop();
    if (!res) {
      DialogUtils.showErrorDialog(
        context,
        content: 'Xoá sản phẩm khỏi giỏ hàng thất bại',
      );
    } else {
      widget.onChangeQuantitySuccess?.call();
    }
    return res;
  }
}
