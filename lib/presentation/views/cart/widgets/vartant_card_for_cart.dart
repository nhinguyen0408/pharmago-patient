import 'package:flutter/material.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/shared/utils/event.dart';

class VariantCardForCart extends StatelessWidget {
  const VariantCardForCart({
    super.key,
    this.onCheckbox,
    required this.dataVariant,
    required this.onChangeQuantity,
  });

  final Function(bool?)? onCheckbox;
  final CartEntity dataVariant;
  final Function(int) onChangeQuantity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthDevice(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: 50,
              child: Checkbox(
                value: dataVariant.selected,
                onChanged: onCheckbox,
                activeColor: mainColor,
              ),
            ),
          ),
          const SizedBox(width: sp8),
          SizedBox(
            width: 56,
            height: 56,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: dataVariant.variant?.image != null
                  ? Image.network(
                      dataVariant.variant!.image!,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/imgs/logo.png',
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: sp16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    dataVariant.variant?.title ?? '',
                    style: p5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: sp8),
                Text(dataVariant.unit?.title ?? '',
                    style: p7.copyWith(color: greyColor)),
                const SizedBox(height: sp8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dataVariant.variant?.price != null
                        ? FormatCurrency(dataVariant.variant?.price)
                        : ''),
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
                          Text(dataVariant.quantity.toString()),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
