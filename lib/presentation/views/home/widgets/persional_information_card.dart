import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/entities/persional_profile_entity.dart';

class PersionalHomeCard extends StatelessWidget {
  const PersionalHomeCard({
    super.key,
    required this.dataUser,
    this.countItemCart = 0,
  });
  final PersionalProfileEntity? dataUser;
  final int countItemCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthDevice(context),
      padding: const EdgeInsets.all(sp16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor_2,
            width: 1.0,
          ),
        ),
        color: whiteColor,
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Image.asset(
              'assets/imgs/logo.png',
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
                    'Hôm nay bạn thế nào? ',
                    style: p6.copyWith(color: greyColor),
                  ),
                  SvgPicture.asset('assets/icons/ic_clapping_hand.svg'),
                ],
              ),
              Text(
                dataUser?.fullname ?? 'Người dùng Pharmago',
                style: p5.copyWith(color: blackColor),
              )
            ],
          ),
          const SizedBox(width: sp8),
          const Spacer(),
          Row(
            children: [
              InkWell(
                onTap: () => context.router.push(const CartRoute()),
                child: Stack(
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
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: sp4),
                        decoration: BoxDecoration(
                          color: red_3,
                          borderRadius: BorderRadius.circular(sp16),
                        ),
                        child: Text(countItemCart.toString(), style: p9.copyWith(color: whiteColor),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
