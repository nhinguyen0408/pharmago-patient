
import '../../../../../data/models/base/response.dart';
import '../../data/models/response_authen_model.dart';
import '../../data/models/response_register_model.dart';

abstract class AuthenticationRepository {
  Future<BaseResponseModel<ResponseAuthModel>> userLogin({
    required String username,
    required String password,
  });

  Future<BaseResponseModel<ResponseRegisterModel>> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  });

  Future<BaseResponseModel<bool>> verify({
    required String email,
    required String otp,
  });

  Future<BaseResponseModel> reSendOTP({
    required String email,
  });
}