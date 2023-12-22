import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/authentication/data/models/persional_profile_model.dart';

abstract class PersionalRepository {
  Future<BaseResponseModel<PersionalProfileModel>> getPersionalProfile();
}