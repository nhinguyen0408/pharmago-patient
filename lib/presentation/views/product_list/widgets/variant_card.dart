import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
import 'package:pharmago_patient/shared/utils/event.dart';
import 'package:pharmago_patient/shared/views/empty_container.dart';

class VariantCart extends StatelessWidget {
  const VariantCart({super.key, required this.data, required this.dataDrugstore});

  final VariantEntity data;
  final DrugstoreEntity dataDrugstore;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(VariantDetailRoute(id: data.id.toString(), dataDrugstore: dataDrugstore));
      },
      child: BaseContainer(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 139,
              width: 139,
              child: data.image != null
                  ? Image.network(
                      data.image!,
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
            const SizedBox(height: sp8),
            SizedBox(
              height: sp48,
              child: Text(
                data.title ?? 'Chưa cập nhật',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: p6,
              ),
            ),
            Text(
              data.price != null ? FormatCurrency(data.price!) : '0',
              style: p5,
            ),
            const SizedBox(height: sp8),
            Row(
              children: [
                Text('Mua ngay', style: h6.copyWith(color: mainColor)),
                const Spacer(),
                const Icon(
                  Icons.shopping_cart_outlined,
                  color: mainColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
