import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/usecase/resend_otp_use_case.dart';
import '../../domain/usecase/verify_account_use_case.dart';
import 'verify_account_state.dart';

@injectable
class VerifyAccountCubit extends Cubit<VerifyAccountState> {
  VerifyAccountCubit(
    this._verifyAccountUsecase,
    this._resendOtpUseCase,
  ) : super(const VerifyAccountState());

  final VerifyAccountUsecase _verifyAccountUsecase;
  final ResendOtpUseCase _resendOtpUseCase;

  void init(String email) {
    emit(
      state.copyWith(
        email: email,
      ),
    );
  }

  void codeChange(String code) {
    emit(state.copyWith(code: code));
  }

  Future<bool> verifyAccount() async {
    final input = VerifyAccountInput(
      email: state.email,
      otp: state.code,
    );
    final res = await _verifyAccountUsecase.execute(input);
    return res.response.data ?? false;
  }


  Future<BaseResponseModel> resendOtp() async {
    final input = ResendOtpInput(
      email: state.email,
    );
    final res = await _resendOtpUseCase.execute(input);
    return res.response;
  }
}
