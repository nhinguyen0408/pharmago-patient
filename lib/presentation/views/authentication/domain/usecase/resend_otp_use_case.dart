import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/repositories/authentication_repository.dart';

@injectable
class ResendOtpUseCase extends BaseFutureUseCase<ResendOtpInput, ResendOtpOutput> {
  final AuthenticationRepository _authenticationRepository;

  ResendOtpUseCase(this._authenticationRepository);
  @override
  Future<ResendOtpOutput> buildUseCase(ResendOtpInput input) async {
    final res = await _authenticationRepository.reSendOTP(email: input.email);
    final output = ResendOtpOutput(
      response: BaseResponseModel(
        code: res.code,
        message: res.data?['message'] ?? res.message,
      ),
    );
    return output;
  }

}

class ResendOtpInput extends BaseInput {
  final String email;

  ResendOtpInput({required this.email});
}

class ResendOtpOutput extends BaseOutput {
  final BaseResponseModel response;
  ResendOtpOutput({required this.response});
}