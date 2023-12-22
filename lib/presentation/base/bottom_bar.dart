import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/constants/pref_key.dart';
import '../../shared/constants/storage/shared_preference.dart';
import '../constants/asset_path.dart';
import '../constants/colors.dart';
import '../constants/size_device.dart';
import '../constants/spacing.dart';

enum TabCode {
  home('Trang chủ', '/bottom_bar/ic_home.svg', ''),
  health('HS Sức khoẻ', '/bottom_bar/ic_health.svg', ''),
  drugstore('Nhà thuốc', '/bottom_bar/ic_drugstore.svg', ''),
  persional('Cá nhân', '/bottom_bar/ic_persional.svg', '');

  const TabCode(this.title, this.pathIcon, this.pathIconActive);

  final String title;
  final String pathIcon;
  final String pathIconActive;
}

class BuildBottomBar extends StatelessWidget {
  BuildBottomBar({
    Key? key,
    required this.pageCode,
    this.onTap,
  }) : super(key: key);

  final TabCode pageCode;
  final Function(TabCode value)? onTap;
  final role = AppSharedPreference.instance.getValue(PrefKeys.userCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: widthDevice(context),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 40), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: sp12),
        child: GridView(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: TabCode.values.toList().length,
          ),
          children: TabCode.values.toList()
            .map(
              (e) => InkWell(
                onTap: () {
                  onTap?.call(e);
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      '${AssetsPath.icon}${e.pathIcon}',
                      width: sp20,
                      color: pageCode == e ? mainColor : greyColor,
                    ),
                    const SizedBox(height: sp8),
                    Text(
                      e.title,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight:
                            pageCode == e ? FontWeight.w500 : FontWeight.w400,
                        color: pageCode == e ? mainColor : greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  final dynamic context;

  BNBCustomPainter({required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = whiteColor
      ..style = PaintingStyle.fill;
    final Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 16, 0);
    path.lineTo(size.width * 0.357, 0);
    path.quadraticBezierTo(size.width * 0.385, 0, size.width * 0.405, 13.5);
    // path.arcToPoint(Offset(size.width*0.6, 20), radius: Radius.circular(8), clockwise: false);
    path.quadraticBezierTo(size.width * 0.445, 36, size.width * 0.5, 36);
    path.quadraticBezierTo(size.width * 0.555, 36, size.width * 0.595, 13.5);
    path.quadraticBezierTo(size.width * 0.615, 0, size.width * 0.643, 0);
    path.lineTo(size.width - 16, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);
    path.lineTo(size.width, 80);
    path.lineTo(0, 80);
    path.close();

    canvas.drawPath(path, paint);
    // canvas.drawShadow(path, Colors.black45, 1, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
