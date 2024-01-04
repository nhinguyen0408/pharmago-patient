import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/shared/utils/validate.dart';
import '../../../../presentation/base/button.dart';
import '../../../../presentation/base/text_field.dart';
import '../../../../presentation/constants/colors.dart';
import '../../../../presentation/constants/size_device.dart';
import '../../../../presentation/constants/spacing.dart';
import '../../../../shared/utils/dialog_utils.dart';

import '../../../constants/typography.dart';
import '../cubit/register_cubit/register_cubit.dart';
import '../cubit/register_cubit/register_state.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final keyForm = GlobalKey<FormState>();
  final myBloc = getIt.get<RegisterCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => myBloc,
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: whiteColor,
            resizeToAvoidBottomInset: true,
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  width: widthDevice(context),
                  height: heightDevice(context),
                  padding: const EdgeInsets.symmetric(
                    horizontal: sp24,
                    vertical: sp32,
                  ),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text(
                          'Đăng ký',
                          style: p3.copyWith(color: blackColor),
                        ),
                        gapHeight(sp12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/imgs/logo.png'),
                          ],
                        ),
                        gapHeight(sp48),
                        AppInput(
                          hintText: '',
                          label: 'Email',
                          backgroundColor: bg_4,
                          borderColor: bg_4,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: greyColor,
                          ),
                          required: true,
                          textInputType: TextInputType.emailAddress,
                          onConfirm: (p0) => myBloc.checkEmailExist(),
                          onTapOutside: myBloc.checkEmailExist,
                          onChanged: (value) =>
                              myBloc.formRegisterChange(email: value),
                        ),
                        Visibility(
                          visible: state.isExistedEmail,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: sp24, top: sp8),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Email đã được đăng ký',
                                style: p7.copyWith(color: red_3),
                              ),
                            ),
                          ),
                        ),
                        gapHeight(sp16),
                        AppInput(
                          label: 'Số điện thoại',
                          hintText: 'Nhập số điện thoại của bạn',
                          textInputType: TextInputType.phone,
                          backgroundColor: bg_4.withOpacity(0.5),
                          borderColor: bg_4,
                          required: true,
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            size: sp20,
                            color: greyColor,
                          ),
                          onChanged: (value) =>
                              myBloc.formRegisterChange(phone: value),
                          validate: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Vui lòng nhập số điện thoại';
                            } else if (!isPhoneNumberValid(value ?? '')) {
                              return 'Sai định dạng số điện thoại.';
                            }
                          },
                        ),
                        gapHeight(sp16),
                        BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                AppInput(
                                  label: 'Mật khẩu',
                                  hintText: 'Nhập mật khẩu',
                                  backgroundColor: bg_4.withOpacity(0.5),
                                  borderColor: bg_4,
                                  show: state.showPassword,
                                  maxLines: 1,
                                  required: true,
                                  onChanged: (value) {
                                    myBloc.formRegisterChange(password: value);
                                  },
                                  suffixIcon: InkWell(
                                    onTap: myBloc.showPasswordChange,
                                    child: const Icon(
                                      Icons.remove_red_eye_rounded,
                                      color: borderColor_4,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    size: sp20,
                                    color: greyColor,
                                  ),
                                  validate: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Vui lòng nhập mật khẩu';
                                    }
                                  },
                                ),
                                gapHeight(sp16),
                                AppInput(
                                  label: 'Nhập lại mật khẩu',
                                  hintText: 'Nhập lại mật khẩu',
                                  backgroundColor: bg_4.withOpacity(0.5),
                                  borderColor: bg_4,
                                  show: state.showConfirmPassword,
                                  maxLines: 1,
                                  required: true,
                                  onChanged: (value) {
                                    myBloc.formRegisterChange(
                                        confirmPassword: value);
                                  },
                                  suffixIcon: InkWell(
                                    onTap: myBloc.showConfirmPasswordChange,
                                    child: const Icon(
                                      Icons.remove_red_eye_rounded,
                                      color: borderColor_4,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    size: sp20,
                                    color: greyColor,
                                  ),
                                  validate: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Vui lòng nhập mật khẩu';
                                    } else if (value != state.password) {
                                      return 'Mật khẩu không khớp';
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        gapHeight(sp24),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: MainButton(
                                title: 'Đăng ký',
                                event: () {
                                  _singUpHandle(context);
                                },
                              ),
                            ),
                            // gapWidth(sp12),
                            // Container(
                            //   width: sp48,
                            //   padding: const EdgeInsets.all(sp12),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(sp12),
                            //       border: Border.all(color: borderColor_2)),
                            //   child: Image.asset(
                            //       '${AssetsPath.image}/login/img_face_id.png'),
                            // )
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: widthDevice(context),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Bạn đã có tài khoản? ',
                              style: p4.copyWith(color: blackColor),
                              children: [
                                TextSpan(
                                  text: 'Đăng nhập ngay',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        context.router.push(const LoginRoute()),
                                  style: p4.copyWith(color: green_1),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // FutureBuilder(
                        //   future: AuthenticationService.initializerFirebase(),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.hasError) {
                        //       return const Text('Error initializing Firebase');
                        //     } else if (snapshot.connectionState ==
                        //         ConnectionState.done) {
                        //       return const GoogleSignInButton();
                        //     }
                        //     return const CircularProgressIndicator(
                        //       valueColor: AlwaysStoppedAnimation<Color>(
                        //         mainColor,
                        //       ),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _singUpHandle(BuildContext context) async {
    final validate = keyForm.currentState?.validate();
    if (validate == false) {
      return;
    }
    if (await myBloc.checkEmailExist()) {
      return;
    }
    DialogUtils.showLoadingDialog(
      context,
      content: 'Đang đăng ký vui lòng đợi!',
    );
    myBloc.register().then((value) {
      Navigator.of(context).pop();
      if (value.code == 200) {
        context.router.push(
          VerifyAccountRoute(
            email: myBloc.state.email,
          ),
        );
        return;
      }
      DialogUtils.showErrorDialog(
        context,
        content: 'Đăng ký thất bại \n ${value.data}',
      );
      return;
    });
  }
}
