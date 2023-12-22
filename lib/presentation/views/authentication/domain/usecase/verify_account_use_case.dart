import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/repositories/authentication_repository.dart';

import '../../../../../domain/usecase/base/future_use_case.dart';
import '../../../../../domain/usecase/base/io/input.dart';
import '../../../../../domain/usecase/base/io/output.dart';

@injectable
class VerifyAccountUsecase
    extends BaseFutureUseCase<VerifyAccountInput, VerifyAccountOutput> {
  VerifyAccountUsecase(this._authenticationRepository);
  final AuthenticationRepository _authenticationRepository;

  @override
  Future<VerifyAccountOutput> buildUseCase(VerifyAccountInput input) async {
    final res = await _authenticationRepository.verify(
      email: input.email,
      otp: input.otp,
    );
    final output = VerifyAccountOutput(
      response: BaseResponseModel(
        code: res.code,
        message: res.message,
        data: res.code != null && res.code  == 200,
      ),
    );
    return output;
  }
}

class VerifyAccountInput extends BaseInput {
  final String email;
  final String otp;
  VerifyAccountInput({
    required this.email,
    required this.otp,
  });
}

class VerifyAccountOutput extends BaseOutput {
  final BaseResponseModel<bool> response;
  VerifyAccountOutput({required this.response});
}
