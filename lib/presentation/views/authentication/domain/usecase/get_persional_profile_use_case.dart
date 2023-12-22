import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/views/authentication/data/mapper/persional_profile_mapper.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/entities/persional_profile_entity.dart';
import 'package:pharmago_patient/presentation/views/authentication/domain/repositories/persional_repository.dart';
import 'package:pharmago_patient/shared/constants/pref_key.dart';
import 'package:pharmago_patient/shared/constants/storage/shared_preference.dart';

import '../../../../../data/models/base/response.dart';
import '../../../../../domain/usecase/base/future_use_case.dart';
import '../../../../../domain/usecase/base/io/input.dart';
import '../../../../../domain/usecase/base/io/output.dart';

@injectable
class PersionalProfileUsecase
    extends BaseFutureUseCase<PersionalProfileInput, PersionalProfileOutput> {
  PersionalProfileUsecase(
    this._profilePersionalMapper,
    this._persionalRepository,
  );

  final ProfilePersionalMapper _profilePersionalMapper;
  final PersionalRepository _persionalRepository;

  @override
  Future<PersionalProfileOutput> buildUseCase(
      PersionalProfileInput input) async {
    final res = await _persionalRepository.getPersionalProfile();

    final dataEntity = _profilePersionalMapper.mapToEntity(res.data);
    await AppSharedPreference.instance
          .setValue(PrefKeys.user, dataEntity.id);
    await AppSharedPreference.instance
        .setValue(PrefKeys.username, dataEntity.fullname);

    final output = PersionalProfileOutput(
      response: BaseResponseModel(
        code: res.code,
        message: res.message,
        data: dataEntity,
      ),
    );
    return output;
  }
}

class PersionalProfileInput extends BaseInput {
}

class PersionalProfileOutput extends BaseOutput {
  final BaseResponseModel<PersionalProfileEntity> response;
  const PersionalProfileOutput({required this.response});
}
