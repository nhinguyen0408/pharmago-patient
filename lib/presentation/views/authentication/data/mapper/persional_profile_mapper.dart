import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/mapper/base/data_mapper.dart';
import 'package:pharmago_patient/presentation/views/authentication/data/models/persional_profile_model.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/entities/persional_profile_entity.dart';

@injectable
class ProfilePersionalMapper
    extends BaseDataMapper<PersionalProfileModel, PersionalProfileEntity> {
  @override
  PersionalProfileEntity mapToEntity(PersionalProfileModel? data) {
    return PersionalProfileEntity(
      id: data?.id,
      code: data?.code,
      username: data?.username,
      verified: data?.verified,
      fullname: data?.fullname,
      phone: data?.phone,
      email: data?.email,
      dateJoined: data?.dateJoined,
    );
  }
}
