import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';
import '../constants/spacing.dart';
import '../constants/typography.dart';

// ignore: non_constant_identifier_names
Widget AppInput({
  String? initialValue,
  String? label,
  required String hintText,
  TextEditingController? controller,
  TextInputType textInputType = TextInputType.text,
  Widget? suffixIcon,
  Widget? prefixIcon,
  Function(String? value)? validate,
  bool show = true,
  bool isPassword = false,
  int? maxLines,
  FocusNode? fn,
  bool required = false,
  Function? onTap,
  Color? borderColor,
  Color? backgroundColor,
  Function(String)? onChanged,
  Function(String)? onConfirm,
  Function()? onTapOutside,
  bool readOnly = false,
  TextAlign textAlign = TextAlign.start,
  TextStyle? labelStyle,
  List<TextInputFormatter>? inputFormatters,
  // required Function onChanged
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // if (label != null)
      //   RichText(
      //     text: TextSpan(
      //       text: label,
      //       style: labelStyle ?? p5.copyWith(color: blackColor),
      //       children: [
      //         if (required)
      //           TextSpan(text: ' *', style: p5.copyWith(color: red_1))
      //       ],
      //     ),
      //   ),
      // // Text('$label', style: p5),
      // if (label != null) const SizedBox(height: sp8),
      TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        onTap: () {
          if (onTap != null) onTap();
        },
        onChanged: (String? value) {
          if (value != null && onChanged != null) {
            onChanged(value);
          }
        },
        onFieldSubmitted: (value) {
          if (onConfirm != null) {
            onConfirm(value);
          }
        },
        onTapOutside: (event) => onTapOutside?.call(),
        maxLines: maxLines,
        keyboardType: textInputType,
        controller: controller,
        obscureText: !show,
        focusNode: fn,
        textAlign: textAlign,
        validator: (value) {
          return validate?.call(value);
        },
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          label: Row(
            children: [
              Text(
                label ?? '',
                style: p5.copyWith(color: greyColor),
              ),
              Visibility(
                visible: required,
                child: Text(
                  ' *',
                  style: p5.copyWith(color: red_1),
                ),
              ),
            ],
          ),
          fillColor: backgroundColor,
          filled: backgroundColor != null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: sp16, horizontal: sp24),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: borderColor ?? borderColor_2,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: borderColor ?? borderColor_2,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: borderColor ?? borderColor_2,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: mainColor,
              width: 1,
            ),
          ),
          hintText: hintText,
          hintStyle: p6.copyWith(color: greyColor),
          // label: Text(
          //   label,
          //   style: p5,
          // ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          // isPassword
          //   ? IconButton(
          //       icon: Icon(
          //         show ? Icons.visibility : Icons.visibility_off_outlined,
          //       ),
          //       onPressed: () {
          //         _loginController.changeShowPassword(value: show ? false.obs : true.obs);
          //       },
          //     )
          //   : Spacer(),
        ),
      ),
    ],
  );
}

// ignore: must_be_immutable
class InputCurrency extends StatelessWidget {
  final String? label;
  final String hintText;
  final TextEditingController controller;
  Widget? suffixIcon = SizedBox(
    width: 50,
    child: Center(
      child: Text(
        'VNĐ',
        style: p6.copyWith(
          color: greyColor,
        ),
      ),
    ),
  );
  final Function validate;
  final FocusNode? fn;
  final bool required;
  final Function(String)? onChanged;
  final Function(String)? onConfirm;
  final List<TextInputFormatter>? inputFormatters;

  InputCurrency({
    super.key,
    this.label,
    required this.hintText,
    this.suffixIcon,
    required this.validate,
    required this.controller,
    this.fn,
    this.required = false,
    this.onChanged,
    this.onConfirm,
    this.inputFormatters,
  });

  static const _locale = 'vi';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          RichText(
            text: TextSpan(
              text: '$label',
              style: p5.copyWith(color: blackColor),
              children: [
                if (required)
                  TextSpan(text: ' *', style: p5.copyWith(color: red_1))
              ],
            ),
          ),
        if (label != null) const SizedBox(height: sp8),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: controller,
          focusNode: fn,
          inputFormatters: inputFormatters,
          onChanged: (string) {
            string = _formatNumber(string.replaceAll('.', ''));
            controller.value = TextEditingValue(
              text: string,
              selection: TextSelection.collapsed(offset: string.length),
            );
            onChanged?.call(string);
          },
          onFieldSubmitted: (value) {
            onConfirm?.call(value);
          },
          validator: (value) {
            return validate(value);
          },
          decoration: InputDecoration(
            // prefixText: _currency,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: borderColor_2,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: borderColor_2,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: borderColor_2,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: blue_1,
                width: 1,
              ),
            ),
            hintText: hintText,
            hintStyle: p6.copyWith(color: greyColor),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

Widget AppInputSupport({
  String? initialValue,
  String? label,
  EdgeInsetsGeometry? padding,
  double? radius,
  required String hintText,
  TextEditingController? controller,
  TextInputType textInputType = TextInputType.text,
  Widget? suffixIcon,
  Widget? prefixIcon,
  required Function(String? value) validate,
  bool show = true,
  bool isPassword = false,
  int? maxLines,
  FocusNode? fn,
  bool required = false,
  Function? onTap,
  Color? borderColor,
  Color? backgroundColor,
  Function(String)? onChanged,
  Function(String)? onConfirm,
  Function()? onTapOutside,
  bool readOnly = false,
  TextAlign textAlign = TextAlign.start,
  TextStyle? labelStyle,
  List<TextInputFormatter>? inputFormatters,
  // required Function onChanged
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label != null)
        RichText(
          text: TextSpan(
            text: label,
            style: labelStyle ?? p5.copyWith(color: blackColor),
            children: [
              if (required)
                TextSpan(text: ' *', style: p5.copyWith(color: red_1))
            ],
          ),
        ),
      // Text('$label', style: p5),
      if (label != null) const SizedBox(height: sp8),
      TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        onTap: () {
          if (onTap != null) onTap();
        },
        onChanged: (String? value) {
          if (value != null && onChanged != null) {
            onChanged(value);
          }
        },
        onFieldSubmitted: (value) {
          if (onConfirm != null) {
            onConfirm(value);
          }
        },
        onTapOutside: (event) => onTapOutside?.call(),
        maxLines: maxLines,
        keyboardType: textInputType,
        controller: controller,
        obscureText: !show,
        focusNode: fn,
        textAlign: textAlign,
        validator: (value) {
          return validate(value);
        },
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          fillColor: backgroundColor,
          filled: backgroundColor != null,
          contentPadding: padding ?? const EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
            borderSide: BorderSide(
              color: borderColor ?? borderColor_2,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
            borderSide: BorderSide(
              color: borderColor ?? borderColor_2,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
            borderSide: BorderSide(
              color: borderColor ?? borderColor_2,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
            borderSide: const BorderSide(
              color: whiteColor,
              width: 1,
            ),
          ),
          hintText: hintText,
          hintStyle: p6.copyWith(color: greyColor),
          // label: Text(
          //   label,
          //   style: p5,
          // ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          // isPassword
          //   ? IconButton(
          //       icon: Icon(
          //         show ? Icons.visibility : Icons.visibility_off_outlined,
          //       ),
          //       onPressed: () {
          //         _loginController.changeShowPassword(value: show ? false.obs : true.obs);
          //       },
          //     )
          //   : Spacer(),
        ),
      ),
    ],
  );
}
