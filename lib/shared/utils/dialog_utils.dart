
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../presentation/base/calendar.dart';
import '../../presentation/base/loading.dart';
import '../../presentation/base/popup_noti.dart';
import '../../presentation/constants/colors.dart';
import '../../presentation/constants/size_device.dart';
import '../../presentation/constants/spacing.dart';
import '../../presentation/constants/typography.dart';
import '../constants/enum/status_noti.dart';

class DialogUtils {
  static showLoadingDialog(
    BuildContext context, {
    required String content,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(sp16)),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(sp16),
            ),
            width: widthDevice(context) - sp32,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BaseLoading(),
                const SizedBox(height: sp24),
                const Text('Thông báo', style: h3),
                const SizedBox(height: sp12),
                Text(
                  content,
                  style: p4.copyWith(color: greyColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showSuccessDialog(
    BuildContext context, {
    required String content,
    VoidCallback? accept,
    VoidCallback? close,
    String? titleConfirm,
    String? titleClose,
    bool? barrierDismissible,
  }) {
    showDialog(
      barrierDismissible: barrierDismissible ?? true,
      context: context,
      builder: (context) {
        return BasePopupNoti(
          click: accept,
          close: close,
          content: content,
          status: StatusNoti.SUCCESS,
          titleConfirm: titleConfirm,
          titleClose: titleClose,
        );
      },
    );
  }

  static showDialogWithTitleAndOptionButton(
    BuildContext context, {
    required String content,
    required VoidCallback okButton,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(sp16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Text(content),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("CANCEL")),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        okButton();
                      },
                      child: const Text("OK"),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static showErrorDialog(
    BuildContext context, {
    required String content,
    VoidCallback? accept,
    VoidCallback? close,
    String? titleConfirm,
    String? titleClose,
  }) {
    // developer.log(
    //   "value: data type: ${data.runtimeType}",
    //   name: 'tz',
    // );
    showDialog(
      context: context,
      builder: (context) {
        return BasePopupNoti(
          click: accept,
          close: close,
          content: content,
          status: StatusNoti.ERROR,
          titleConfirm: titleConfirm,
          titleClose: titleClose,
        );
      },
    );
  }

  static Future<void> showCalendarDialog(BuildContext context,
      {required List<String?> selectedDate,
      Function(String)? onConfirm,
      DateRangePickerSelectionMode selectionMode =
          DateRangePickerSelectionMode.range}) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        reverseTransitionDuration: const Duration(milliseconds: 0),
        transitionDuration: const Duration(milliseconds: 100),
        pageBuilder: (_, __, ___) {
          return Material(
            elevation: 0,
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Listener(
                    onPointerDown: (_) {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      color: Colors.black26,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: sp12),
                  child: Material(
                    elevation: 1,
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(sp8),
                    child: Container(
                      padding: const EdgeInsets.all(sp12),
                      child: CalendarPicker(
                        selectionMode: selectionMode,
                        selectedDate: selectedDate,
                        onConfirm: (value) {
                          onConfirm?.call(value);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
