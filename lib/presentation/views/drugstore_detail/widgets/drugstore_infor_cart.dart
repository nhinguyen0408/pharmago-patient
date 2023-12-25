import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmago_patient/presentation/base/text_field.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore_detail/cubit/drugstore_detail_cubit.dart';

class DrugstoreInformationCard extends StatelessWidget {
  const DrugstoreInformationCard({
    super.key,
    required this.data,
    required this.cubit,
  });
  final DrugstoreEntity? data;
  final DrugstoreDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthDevice(context),
      padding: const EdgeInsets.all(sp16),
      decoration: const BoxDecoration(
        color: mainColor,
        border: Border(
          bottom: BorderSide(
            color: borderColor_2,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.chevron_left, color: whiteColor,),
              ),
              const SizedBox(width: sp8),
              ClipRRect(
                borderRadius: BorderRadius.circular(sp24),
                child: Image.asset(
                  'assets/imgs/img_shop.png',
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: sp8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Chào mừng bạn đến hiệu thuốc ',
                        style: p9.copyWith(color: whiteColor),
                      ),
                      SvgPicture.asset('assets/icons/ic_clapping_hand.svg'),
                    ],
                  ),
                  
                  SizedBox(
                    width: 200,
                    child: Text(
                      data?.name ?? 'Chưa cập nhật',
                      style: p5.copyWith(color: whiteColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )
                ],
              ),
              const SizedBox(width: sp8),
              const Spacer(),
              Row(
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: borderColor_2),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: sp16),
          AppInputSupport(
            hintText: 'Tìm kiếm',
            backgroundColor: whiteColor,
            prefixIcon: const Icon(
              Icons.search,
              color: blackColor,
              size: 20,
            ),
            initialValue: cubit.state.keySearchVariant,
            onConfirm: cubit.onChangeKeySearchVariant,
            borderColor: borderColor_2,
            validate: (String? value) {},
          ),
        ],
      ),
    );
  }
}
