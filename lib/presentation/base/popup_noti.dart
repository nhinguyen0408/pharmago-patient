
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/constants/enum/status_noti.dart';
import '../constants/asset_path.dart';
import '../constants/colors.dart';
import '../constants/size_device.dart';
import '../constants/spacing.dart';
import '../constants/typography.dart';
import 'button.dart';

// ignore: must_be_immutable
class BasePopupNoti extends StatelessWidget {
  BasePopupNoti({
    super.key,
    required this.content,
    required this.status,
    this.click,
    this.close,
    this.titleClose,
    this.titleConfirm,
  });

  String content;
  Function? click;
  Function? close;
  StatusNoti status;

  String? titleConfirm;
  String? titleClose;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(sp16)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(sp16),
          ),
          width: max(widthDevice(context) - sp32, 343),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (status == StatusNoti.LOADING)
                const CircularProgressIndicator()
              else
                CircleAvatar(
                  radius: 30,
                  backgroundColor: status == StatusNoti.SUCCESS
                      ? green_2
                      : status == StatusNoti.WARNING
                          ? yellow_2
                          : red_2,
                  child: SvgPicture.asset(
                    '${AssetsPath.icon}/${status == StatusNoti.SUCCESS ? 'noti/icon_noti_success.svg' : status == StatusNoti.WARNING ? 'noti/warning.svg' : 'noti/icon_noti_err.svg'}',
                  ),
                ),
              const SizedBox(height: sp24),
              Text(status == StatusNoti.SUCCESS ? 'Thành công' : 'Cảnh báo', style: h3.copyWith(color: blackColor)),
              const SizedBox(height: sp12),
              Text(
                content,
                style: p4.copyWith(color: greyColor),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              if (status != StatusNoti.LOADING) const SizedBox(height: sp24),
              if (status != StatusNoti.LOADING)
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (click != null)
                      Expanded(
                        flex: 1,
                        child: ExtraButton(
                          title: titleClose ?? 'Quay lại',
                          event: () {
                            if (close != null) close!.call();
                          },
                          borderColor: borderColor_2,
                          largeButton: true,
                          icon: null,
                        ),
                      ),
                    if (click != null) const SizedBox(width: sp16),
                    if (click != null)
                      Expanded(
                        flex: 1,
                        child: supportButton(
                          title: titleConfirm ?? 'Xác nhận',
                          event: () {
                            if (click != null) {
                              click!();
                            }
                          },
                          largeButton: true,
                          icon: null,
                          backgroundColor: mainColor,
                          color: whiteColor
                        ),
                      ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
