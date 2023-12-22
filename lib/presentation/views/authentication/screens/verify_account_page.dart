import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/base/button.dart';
import 'package:pharmago_patient/presentation/constants/asset_path.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/authentication/cubit/verify_account_cubit/verify_account_state.dart';
import 'package:pharmago_patient/shared/utils/dialog_utils.dart';

import '../../../constants/typography.dart';
import '../cubit/verify_account_cubit/verify_account_cubit.dart';
import '../widgets/pin_code_view.dart';

@RoutePage()
class VerifyAccountPage extends StatefulWidget {
  const VerifyAccountPage({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  final myBloc = getIt.get<VerifyAccountCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerifyAccountCubit>(
      create: (context) => myBloc..init(widget.email),
      child: BlocBuilder<VerifyAccountCubit, VerifyAccountState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: bg_4,
            body: Container(
              height: heightDevice(context),
              width: widthDevice(context),
              padding:
                  const EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(sp16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(sp12),
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: blackColor.withOpacity(0.1),
                            blurRadius: sp4,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(
                                Icons.arrow_back_ios_rounded,
                                color: blackColor,
                              ),
                            ),
                          ],
                        ),
                        gapHeight(sp24),
                        Image.asset(
                          '${AssetsPath.image}/logo.png',
                          width: sp64,
                        ),
                        gapHeight(sp24),
                        RichText(
                          text: TextSpan(
                            text: 'Tài khoản',
                            style: p3.copyWith(color: blackColor),
                            children: [
                              TextSpan(
                                text: ' ${widget.email} ',
                                style: const TextStyle(color: mainColor),
                              ),
                              const TextSpan(
                                text: 'đã được tạo!',
                              ),
                            ],
                          ),
                        ),
                        gapHeight(sp24),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(sp16),
                          decoration: BoxDecoration(
                            color: bg_4,
                            borderRadius: BorderRadius.circular(sp12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Mã OTP đã được gửi tới Email:\n',
                                      style: p4.copyWith(color: blackColor),
                                    ),
                                    TextSpan(
                                      text: widget.email,
                                      style: p3.copyWith(color: blackColor),
                                    ),
                                  ],
                                ),
                              ),
                              gapHeight(sp4),
                              Text(
                                'OTP chỉ có hiệu lực trong 60 giây',
                                style: p4.copyWith(color: yellow_1),
                              )
                            ],
                          ),
                        ),
                        gapHeight(sp16),
                        InkWell(
                          onTap: () {
                            _resendOtp();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.refresh_rounded,
                                size: sp16,
                                color: blue_1,
                              ),
                              gapWidth(sp8),
                              Text(
                                'Gửi lại mã',
                                style: p5.copyWith(color: blue_1),
                              ),
                            ],
                          ),
                        ),
                        gapHeight(sp16),
                        PinCodeView(
                          onChanged: myBloc.codeChange,
                          onCompleted: (value) {
                            myBloc.codeChange(value);
                            _verifyAccount();
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: MainButton(
                            title: 'Xác nhận',
                            event: _verifyAccount,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _verifyAccount() {
    DialogUtils.showLoadingDialog(
      context,
      content: 'Đang xác thực tài khoản, vui lòng đợi!',
    );

    myBloc.verifyAccount().then((value) {
      Navigator.of(context).pop();
      if (value) {
        DialogUtils.showSuccessDialog(
          context,
          barrierDismissible: false,
          content: 'Xác thực tài khoản thành công',
          titleConfirm: 'Đăng nhập',
          accept: () {
            context.router.push(const LoginRoute());
          },
        );
      } else {
        DialogUtils.showErrorDialog(
          context,
          content: 'Xác thực tài khoản thất bại',
        );
      }
    });
  }

  void _resendOtp() {
    DialogUtils.showLoadingDialog(
      context,
      content: 'Đang gửi lại mã, vui lòng đợi!',
    );

    myBloc.resendOtp().then((value) {
      Navigator.of(context).pop();
      if (value.code == 200) {
        myBloc.codeChange('');
        DialogUtils.showSuccessDialog(
          context,
          barrierDismissible: false,
          content: 'Gửi lại mã thành công',
          titleConfirm: 'Đồng ý',
          accept: () {
            Navigator.of(context).pop();
          },
        );
      } else {
        DialogUtils.showErrorDialog(
          context,
          content: 'Gửi lại mã thất bại \n ${value.message}',
        );
      }
    });
  }
}
