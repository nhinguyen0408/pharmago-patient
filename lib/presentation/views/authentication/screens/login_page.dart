import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/shared/utils/validate.dart';
import 'package:pharmago_patient/shared/constants/pref_key.dart';
import 'package:pharmago_patient/shared/constants/storage/shared_preference.dart';
import 'package:pharmago_patient/shared/utils/dialog_utils.dart';

import '../../../base/button.dart';
import '../../../base/text_field.dart';
import '../../../constants/colors.dart';
import '../../../constants/size_device.dart';
import '../../../constants/spacing.dart';
import '../../../constants/typography.dart';
import '../../../di/di.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _myBloc = getIt.get<LoginCubit>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => _myBloc,
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
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
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      'Đăng nhập',
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
                          _myBloc.fieldChange(username: value),
                      validate: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Vui lòng nhập số điện thoại';
                        } else if (!isPhoneNumberValid(value ?? '')) {
                          return 'Sai định dạng số điện thoại.';
                        }
                      },
                    ),
                    gapHeight(sp16),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return AppInput(
                          label: 'Mật khẩu',
                          hintText: 'Nhập mật khẩu',
                          backgroundColor: bg_4.withOpacity(0.5),
                          borderColor: bg_4,
                          show: state.showPassword,
                          maxLines: 1,
                          required: true,
                          onChanged: (value) {
                            _myBloc.fieldChange(password: value);
                          },
                          suffixIcon: InkWell(
                            onTap: _myBloc.showPasswordChange,
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
                        );
                      },
                    ),
                    gapHeight(sp24),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: MainButton(
                            title: 'Đăng nhập',
                            event: _loginEvent,
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
                          text: 'Bạn chưa có tài khoản? ',
                          style: p4.copyWith(color: blackColor),
                          children: [
                            TextSpan(
                              text: 'Đăng ký ngay',
                              recognizer: TapGestureRecognizer()..onTap = () => context.router.push(const RegisterRoute()),
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
      ),
    );
  }

  Future<void> _loginEvent() async {
    final validate = _formKey.currentState!.validate();
    if (!validate) {
      return;
    }

    DialogUtils.showLoadingDialog(
      context,
      content: 'Đang xác thực tài khoản, vui lòng đợi !',
    );

    await _myBloc.login().then((value) async {
      Navigator.of(context).pop();
      if (value.code == 200) {
        context.router.replaceAll([const HomeRoute()]);
      } else {
        DialogUtils.showErrorDialog(
          context,
          content: 'Sai tên tài khoản hoặc mật khẩu',
        );
      }
    });
  }
}
