import 'package:flutter/material.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../constants/colors.dart';
import '../../../constants/spacing.dart';

class PinCodeView extends StatelessWidget {
  const PinCodeView({
    super.key,
    this.controller,
    this.onChanged,
    this.onCompleted,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: const TextStyle(
        color: mainColor,
        fontWeight: FontWeight.w400,
      ),
      textStyle: h4.copyWith(color: blackColor),
      length: 6,
      // obscureText: true,
      // obscuringCharacter: '*',
      // obscuringWidget: const FlutterLogo(
      //   size: 24,
      // ),
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      validator: (v) {
        // if (v!.length < 3) {
        //   return "I'm from validator";
        // } else {
        //   return null;
        // }
        return null;
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(sp8),
        fieldHeight: 50,
        fieldWidth: 50,
        borderWidth: 1,
        disabledColor: whiteColor,
        inactiveColor: bg_2,
        activeColor: mainColor,
        selectedColor: mainColor,
        activeFillColor: whiteColor,
        inactiveFillColor: whiteColor,
        selectedFillColor: whiteColor,
      ),
      cursorColor: blackColor,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      // errorAnimationController: errorController,
      controller: controller,
      keyboardType: TextInputType.number,
      boxShadows: const [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.black12,
          blurRadius: 10,
        ),
      ],
      onCompleted: onCompleted,
      onChanged: onChanged,
      beforeTextPaste: (text) {
        debugPrint("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}
