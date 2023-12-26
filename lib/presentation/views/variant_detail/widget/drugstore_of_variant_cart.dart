import 'package:flutter/material.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class DrugstoreOfVariantCard extends StatelessWidget {
  const DrugstoreOfVariantCard({super.key, required this.data});

  final DrugstoreEntity data;

  void _makePhoneCall(String ?phoneNumber) async {
    if (await canLaunchUrl(Uri(scheme: 'tel', path: phoneNumber))) {
      await launchUrl(Uri(scheme: 'tel', path: phoneNumber));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                  ),
                ],
              )
            ],
          ),
          Positioned(
            top: 12,
            right: sp8,
            child: GestureDetector(
              onTap: () => _makePhoneCall(data.phone),
              child: Text(
                'Liên hệ',
                style: p5.copyWith(color: mainColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
