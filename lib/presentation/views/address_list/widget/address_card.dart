import 'package:flutter/material.dart';
import 'package:pharmago_patient/presentation/base/button.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';
import 'package:pharmago_patient/shared/views/empty_container.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.data, this.onHandel});

  final AddressEntity data;
  final Function()? onHandel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 16,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: BaseContainer(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Địa chỉ giao hàng',
                  style: h6,
                ),
                const Spacer(),
                Visibility(
                  visible: data.isDefault != null && data.isDefault!,
                  child: Text('Mặc định', style: p5.copyWith(color: mainColor),)
                ),
              ],
            ),
            const SizedBox(height: sp16),
            Text(
              data.fullName ?? 'error',
              style: p6.copyWith(color: greyColor),
            ),
            const SizedBox(height: sp8),
            Text(
              data.title ?? 'error',
              style: p6.copyWith(color: greyColor),
            ),
            const SizedBox(height: sp8),
            Visibility(
              visible: data.isDefault != null && !data.isDefault!,
              child: Row(
                children: [
                  Expanded(
                      child: ExtraButton(
                    title: 'Địa chỉ mặc định',
                    event: onHandel,
                    largeButton: false,
                    icon: const Icon(
                      Icons.check,
                      color: mainColor,
                    ),
                    backgroundColor: whiteColor,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
