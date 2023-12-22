import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/shared/constants/enums/type_account_enum.dart';

import '../../../../../data/models/base/response.dart';
import '../../domain/usecase/register_use_case.dart';
import 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUseCase) : super(const RegisterState());

  final RegisterUseCase _registerUseCase;

  void accountTypeChange(AccountTypeEnum value) {
    emit(state.copyWith(accountType: value));
  }

  void nameChange(String value) {
    emit(state.copyWith(name: value));
  }

  void showPasswordChange() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void showConfirmPasswordChange() {
    emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
  }

  void formRegisterChange({
    String? fullName,
    String? phone,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    emit(state.copyWith(
      fullName: fullName ?? state.fullName,
      phone: phone ?? state.phone,
      email: email ?? state.email,
      password: password ?? state.password,
      confirmPassword: confirmPassword ?? state.confirmPassword,
    ));
  }
}

extension HandleApi on RegisterCubit {

  Future<BaseResponseModel> register() async {
    final input = RegisterInput(
      email: state.email,
      fullName: state.fullName,
      password: state.password,
      phone: state.phone,
    );
    final res = await _registerUseCase.execute(input);
    return res.response;
  }
}
