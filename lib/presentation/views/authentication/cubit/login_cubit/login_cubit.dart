import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import '../../domain/usecase/login_use_case.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    this._loginUseCase,
  ) : super(const LoginState());

  final LoginUseCase _loginUseCase;

  void rememberPasswordHandle() {
    emit(state.copyWith(rememberPassword: !state.rememberPassword));
  }

  void showPasswordChange() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void fieldChange({String? username, String? password}) {
    emit(state.copyWith(
      username: username ?? state.username,
      password: password ?? state.password,
    ));
  }

  Future<BaseResponseModel> login() async {
    final input = LoginInput(
      username: state.username,
      password: state.password,
    );
    final res = await _loginUseCase.execute(input);
    return res.response;
  }
}
