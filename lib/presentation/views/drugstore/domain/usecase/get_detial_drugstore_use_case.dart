import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/drugstore/data/mapper/drugstore_mapper.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/repositories/drugstore_repository.dart';

@injectable
class GetDetailDrugstoreUsecase
    extends BaseFutureUseCase<GetDetailDrugstoreInput, GetDetailDrugstoreOutput> {
  final DrugstoreRepository _drugstoreRepository;
  final DrugstoreMapper _drugstoreMapper;
  GetDetailDrugstoreUsecase(this._drugstoreRepository, this._drugstoreMapper);

  @override
  Future<GetDetailDrugstoreOutput> buildUseCase(
      GetDetailDrugstoreInput input) async {
    try {
      final res = await _drugstoreRepository.getDetailDrugstores(
        id: input.id,
      );
      final dataEntity = _drugstoreMapper.mapToEntity(res.data);
      return GetDetailDrugstoreOutput(BaseResponseModel<DrugstoreEntity>(
        code: res.code,
        data: dataEntity,
        message: res.message,
      ));
    } catch (e) {
      return GetDetailDrugstoreOutput(BaseResponseModel<DrugstoreEntity>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class GetDetailDrugstoreInput extends BaseInput {
  final String id;

  GetDetailDrugstoreInput({
    required this.id,
  });
}

class GetDetailDrugstoreOutput extends BaseOutput {
  final BaseResponseModel<DrugstoreEntity> response;

  GetDetailDrugstoreOutput(this.response);
}
