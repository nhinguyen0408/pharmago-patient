import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constants/colors.dart';
import '../constants/spacing.dart';

class BaseLoading extends StatelessWidget {
  const BaseLoading({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: color ?? mainColor,
        size: size ?? sp32,
      ),
    );
  }
}
