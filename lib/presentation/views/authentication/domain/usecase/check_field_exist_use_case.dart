import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/repositories/authentication_repository.dart';
import '../../../../../data/models/base/response.dart';
import '../../../../../domain/usecase/base/future_use_case.dart';
import '../../../../../domain/usecase/base/io/input.dart';
import '../../../../../domain/usecase/base/io/output.dart';

@injectable
class CheckFieldExistUseCase extends BaseFutureUseCase<CheckFieldExistInput, CheckFieldExistOutput> {
  CheckFieldExistUseCase(
    this._authenticationRepository,
  );
  final AuthenticationRepository _authenticationRepository;

  @override
  Future<CheckFieldExistOutput> buildUseCase(CheckFieldExistInput input) async {
    final res = await _authenticationRepository.checkFieldExist(
      key: input.key,
      value: input.value,
    );

    final output = CheckFieldExistOutput(
      response: BaseResponseModel(
        code: res.code,
        message: res.message,
        data: res.data,
      ),
    );
    return output;
  }
}

class CheckFieldExistInput extends BaseInput {
  final String key;
  final String value;
  CheckFieldExistInput({
    required this.key,
    required this.value,
  });
}

class CheckFieldExistOutput extends BaseOutput {
  final BaseResponseModel response;
  const CheckFieldExistOutput({required this.response});
}
