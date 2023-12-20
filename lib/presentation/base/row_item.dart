import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/typography.dart';

class RowItem extends StatelessWidget {
  const RowItem({
    super.key,
    required this.title,
    required this.content,
    this.contetnColor,
    this.titleColor,
    this.titleStyle,
    this.contetnStyle,
  });

  final String title;
  final String content;
  final Color? contetnColor;
  final Color? titleColor;
  final TextStyle? titleStyle;
  final TextStyle? contetnStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: titleStyle ?? p6.copyWith(color: titleColor ?? blackColor),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            content.isEmpty ? 'Chưa có thông tin' : content,
            style: contetnStyle ?? h6.copyWith(color: contetnColor ?? blackColor),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
