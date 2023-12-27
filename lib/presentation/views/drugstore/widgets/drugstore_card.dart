import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';

class DrugstoreCard extends StatelessWidget {
  const DrugstoreCard({
    super.key,
    required this.data,
    this.countItemCart = 0,
    this.canClick = true,
  });
  final DrugstoreEntity data;
  final int countItemCart;
  final bool canClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (canClick)
          context.router.push(DrugstoreDetailRoute(
            id: data.id.toString(),
            countItemCart: countItemCart,
          ))
      },
      child: Container(
        padding: const EdgeInsets.all(sp16),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(sp8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(sp24),
                  child: Image.asset(
                    'assets/imgs/img_shop.png',
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: sp16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name ?? '(Chưa có tên)',
                      style: data.name != null
                          ? p5.copyWith(color: blackColor)
                          : p6.copyWith(
                              color: greyColor,
                              fontStyle: FontStyle.italic,
                            ),
                    ),
                    const SizedBox(height: sp8),
                    Text(
                      data.address ?? 'Chưa cập nhật địa chỉ',
                      style: p9.copyWith(color: greyColor),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
