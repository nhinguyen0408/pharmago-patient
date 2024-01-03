import 'package:flutter/material.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/shared/utils/event.dart';

class VariantCreateOrderCard extends StatelessWidget {
  const VariantCreateOrderCard({
    super.key,
    this.onCheckbox,
    this.quantityInStock,
    required this.dataVariant,
    required this.onChangeQuantity,
    this.canChangeQuantity = false,
  });

  final Function(bool?)? onCheckbox;
  final CartEntity dataVariant;
  final Function(int) onChangeQuantity;
  final bool canChangeQuantity;
  final int? quantityInStock;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthDevice(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    dataVariant.variant?.title ?? '',
                    style: p5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: sp8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataVariant.unit?.title ?? '',
                          style: p6.copyWith(color: greyColor),
                        ),
                        const SizedBox(height: sp8),
                        Visibility(
                          visible: quantityInStock == 0,
                          child: Text('Sản phẩm hết hàng', style: p5.copyWith(color: red_3),),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          dataVariant.variant?.price != null
                              ? '(x${dataVariant.quantity}) ${FormatCurrency(dataVariant.variant?.price)}'
                              : '',
                          style: h5,
                        ),
                        const SizedBox(height: sp4),
                        Visibility(
                          visible: canChangeQuantity,
                          child: SizedBox(
                            width: 100,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    onChangeQuantity(-1);
                                  },
                                  child: const Icon(
                                    Icons.remove_circle_outline,
                                    color: greyColor,
                                    size: 20,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  dataVariant.quantity.toString(),
                                  style: h5,
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    onChangeQuantity(1);
                                  },
                                  child: const Icon(
                                    Icons.add_circle_outline,
                                    color: greyColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
