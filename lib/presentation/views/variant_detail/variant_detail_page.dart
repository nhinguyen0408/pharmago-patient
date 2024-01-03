import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/base/app_bar.dart';
import 'package:pharmago_patient/presentation/base/button.dart';
import 'package:pharmago_patient/presentation/base/loading.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
import 'package:pharmago_patient/presentation/views/variant_detail/cubit/variant_detail_cubit.dart';
import 'package:pharmago_patient/presentation/views/variant_detail/cubit/variant_detail_state.dart';
import 'package:pharmago_patient/presentation/views/variant_detail/widget/drugstore_of_variant_cart.dart';
import 'package:pharmago_patient/shared/utils/dialog_utils.dart';
import 'package:pharmago_patient/shared/utils/event.dart';

@RoutePage()
class VariantDetailPage extends StatefulWidget {
  const VariantDetailPage({
    super.key,
    required this.id,
    required this.dataDrugstore,
  });

  final String id;
  final DrugstoreEntity dataDrugstore;

  @override
  State<VariantDetailPage> createState() => _VariantDetailPageState();
}

class _VariantDetailPageState extends State<VariantDetailPage> {
  final bloc = getIt.get<VariantDetailCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VariantDetailCubit>(
      create: (contex) => bloc..innitialize(variantId: widget.id),
      child: BlocBuilder<VariantDetailCubit, VariantDetailState>(
        builder: (context, state) => Scaffold(
          appBar: const BaseAppBar(
            title: 'Chi tiết sản phẩm',
          ),
          body: state.isLoading
              ? const BaseLoading()
              : SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.all(sp16),
                      width: widthDevice(context),
                      height: heightDevice(context),
                      child: state.dataVariant != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  SizedBox(
                                    height: 286,
                                    width: double.infinity,
                                    child: state.dataVariant?.image != null
                                        ? Image.network(
                                            state.dataVariant!.image!,
                                            width: 139,
                                            height: 139,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/imgs/logo.png',
                                            width: 139,
                                            height: 139,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  const SizedBox(height: sp16),
                                  Text(
                                    state.dataVariant?.title ??
                                        'Không có dữ liệu',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: p4.copyWith(color: blackColor),
                                  ),
                                  const SizedBox(height: sp8),
                                  Text(
                                    state.dataVariant?.price != null
                                        ? '${FormatCurrency(state.dataVariant?.price)} đ'
                                        : 'Không có dữ liệu',
                                    style: p3.copyWith(color: red_3),
                                  ),
                                  const SizedBox(height: sp8),
                                  const Divider(),
                                  DrugstoreOfVariantCard(
                                      data: widget.dataDrugstore),
                                  const Divider(),
                                  const Text(
                                    'Mô tả sản phẩm',
                                    style: p5,
                                  ),
                                  const SizedBox(
                                    height: sp16,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                        state.dataVariant?.description ??
                                            'Không có mô tả'),
                                  ),
                                ])
                          : const Text('Chưa có dữ liệu')),
                ),
          bottomNavigationBar: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(sp16),
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.1),
                  offset: const Offset(0, -sp4),
                  blurRadius: sp4,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: MainButton(
                        title: 'Mua ngay',
                        event: () {
                          _showBottomSheetAddCart(
                              isAddCart: false,
                              onChangeQuantity: (value) =>
                                  bloc.onChangeQuantityAddCart(value));
                        },
                        largeButton: true,
                        icon: null,
                      ),
                    ),
                    const SizedBox(
                      width: sp16,
                    ),
                    Expanded(
                      flex: 1,
                      child: ExtraButton(
                        title: 'Thêm vào giỏ hàng',
                        event: () {
                          _showBottomSheetAddCart(
                              isAddCart: true,
                              onChangeQuantity: (value) =>
                                  bloc.onChangeQuantityAddCart(value));
                        },
                        largeButton: true,
                        icon: null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheetAddCart(
      {bool? isAddCart, required Function(int) onChangeQuantity}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(sp16),
        ),
      ),
      builder: (context) {
        return BlocBuilder<VariantDetailCubit, VariantDetailState>(
            bloc: bloc,
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(sp16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const SizedBox(height: sp8),
                        const Text(
                          'Lựa chọn',
                          style: p6,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  onChangeQuantity(-1);
                                },
                                child: const Icon(
                                  Icons.remove_circle_outline,
                                  color: greyColor,
                                ),
                              ),
                              const Spacer(),
                              Text(state.quantityAddCart.toString()),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  onChangeQuantity(1);
                                },
                                child: const Icon(
                                  Icons.add_circle_outline,
                                  color: greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: sp16),
                    const Text('Đơn vị'),
                    const SizedBox(height: sp16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: state.dataVariant?.units != null &&
                              state.dataVariant!.units!.isNotEmpty
                          ? state.dataVariant!.units!
                              .map(
                                (e) => InkWell(
                                  onTap: () => bloc.onSelectUnit(e.id),
                                  child: UnitCard(
                                    data: e,
                                    acctive: state.unitSelected == e.id,
                                  ),
                                ),
                              )
                              .toList()
                          : [],
                    ),
                    const SizedBox(height: sp16),
                    isAddCart != null && isAddCart
                        ? Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ExtraButton(
                                  event: () {
                                    _buyNow(context);
                                  },
                                  largeButton: true,
                                  icon: const Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 17,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: sp16,
                              ),
                              Expanded(
                                flex: 6,
                                child: MainButton(
                                  title: 'Thêm vào giỏ hàng',
                                  event: () {
                                    _addCart(context);
                                  },
                                  largeButton: true,
                                  icon: null,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ExtraButton(
                                  event: () {
                                    _addCart(context);
                                  },
                                  largeButton: true,
                                  icon: const Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 17,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: sp16,
                              ),
                              Expanded(
                                flex: 6,
                                child: MainButton(
                                  title: 'Mua ngay',
                                  event: () {
                                    _buyNow(context);
                                  },
                                  largeButton: true,
                                  icon: null,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              );
            });
      },
    );
  }

  Future<void> _addCart(BuildContext context) async {
    if (bloc.checkQuantityVariant()) {
      DialogUtils.showLoadingDialog(
        context,
        content: 'Đang thêm vào giỏ hàng',
      );
      final res = await bloc.addCart();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      if (res.code == 200 && context.mounted) {
        DialogUtils.showSuccessDialog(
          context,
          barrierDismissible: false,
          content: 'Thêm sản phẩm vào giỏ hàng thành công',
          titleConfirm: 'Đến Giỏ hàng',
          titleClose: 'OK',
          accept: () {
            Navigator.pop(context);
            context.router.push(CartRoute());
          },
          close: () {
            Navigator.pop(context);
          },
        );
      } else {
        // ignore: use_build_context_synchronously
        DialogUtils.showErrorDialog(
          context,
          content: 'Thêm sản phẩm vào giỏ hàng thất bại',
        );
      }
    } else {
      DialogUtils.showErrorDialog(
        context,
        content: 'Vui lòng chọn số lượng và đơn vị',
      );
    }
  }

  void _buyNow(BuildContext context) {
    if (bloc.checkQuantityVariant()) {
      final List<CartEntity> data = [
        CartEntity(
          quantity: bloc.state.quantityAddCart,
          unit: bloc.state.listUnits.firstWhere((element) =>
              bloc.state.unitSelected != null &&
              element.id == bloc.state.unitSelected),
          variant: bloc.state.dataVariant,
          drugstore: widget.dataDrugstore,
        ),
      ];
      context.router.push(OrderCreateRoute(
        dataCart: data,
        drugstore: widget.dataDrugstore,
        canChangeQuantity: true,
      ));
    } else {
      DialogUtils.showErrorDialog(
        context,
        content: 'Vui lòng chọn số lượng và đơn vị',
      );
    }
  }
}

class UnitCard extends StatelessWidget {
  const UnitCard({super.key, required this.data, required this.acctive});
  final UnitEntity data;
  final bool acctive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: sp16),
      decoration: BoxDecoration(
        border: Border.all(
          color: acctive ? mainColor : greyColor,
        ),
        borderRadius: BorderRadius.circular(sp4),
      ),
      child: Text(data.title ?? ''),
    );
  }
}
