import 'package:flutter/material.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      context,
      Column(
        children: [
          const Icon(
            Icons.hourglass_empty_rounded,
            size: sp48,
            color: greyColor,
          ),
          const SizedBox(height: sp24),
          Text(
            'Danh sách rỗng',
            style: p1.copyWith(color: greyColor),
          ),
          const SizedBox(
            height: sp12,
          ),
        ],
      ),
    );
  }
}


Widget BaseContainer(BuildContext context, Widget child) {
  return Container(
    width: widthDevice(context) - sp32,
    padding: const EdgeInsets.all(sp16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(sp8),
      color: whiteColor,
    ),
    child: child,
  );
}
