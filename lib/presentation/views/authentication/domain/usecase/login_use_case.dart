import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/views/authentication/data/mapper/account_entity_mapper.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/repositories/authentication_repository.dart';
import 'package:pharmago_patient/shared/constants/storage/shared_preference.dart';

import '../../../../../data/models/base/response.dart';
import '../../../../../domain/usecase/base/future_use_case.dart';
import '../../../../../domain/usecase/base/io/input.dart';
import '../../../../../domain/usecase/base/io/output.dart';
import '../../../../../shared/constants/pref_key.dart';
import '../entities/account_entity.dart';

@injectable
class LoginUseCase extends BaseFutureUseCase<LoginInput, LoginOutput> {
  LoginUseCase(
    this._authenticationRepository,
    this._accountEntityMapper,
  );
  final AuthenticationRepository _authenticationRepository;
  final AccountEntityMapper _accountEntityMapper;

  @override
  Future<LoginOutput> buildUseCase(LoginInput input) async {
    final res = await _authenticationRepository.userLogin(
      username: input.username,
      password: input.password,
    );

    final dataEntity = _accountEntityMapper.mapToEntity(res.data?.account);
    final token = res.data?.token;

    await AppSharedPreference.instance.setValue(PrefKeys.token, token);
    final output = LoginOutput(
      response: BaseResponseModel(
        code: res.code,
        message: res.message,
        data: dataEntity,
      ),
    );
    return output;
  }
}

class LoginInput extends BaseInput {
  final String username;
  final String password;
  LoginInput({
    required this.username,
    required this.password,
  });
}

class LoginOutput extends BaseOutput {
  final BaseResponseModel<AccountEntity> response;
  const LoginOutput({required this.response});
}
