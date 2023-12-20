import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/typography.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    Key? key,
    required this.title,
    this.height = kToolbarHeight,
    this.bottom,
    this.actions,
    this.leading,
  }) : super(key: key);

  final String title;
  final double height;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      backgroundColor: whiteColor,
      centerTitle: true,
      title: Text(
        title,
        style: h4.copyWith(color: blackColor),
      ),
      iconTheme: const IconThemeData(color: blackColor),
      actions: actions ?? [],
      bottom: bottom,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
