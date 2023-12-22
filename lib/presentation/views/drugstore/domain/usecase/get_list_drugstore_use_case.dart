import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/drugstore/data/mapper/drugstore_mapper.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/repositories/drugstore_repository.dart';

@injectable
class GetListDrugstoreUsecase
    extends BaseFutureUseCase<GetListDrugstoreInput, GetListDrugstoreOutput> {
  final DrugstoreRepository _drugstoreRepository;
  final DrugstoreMapper _drugstoreMapper;
  GetListDrugstoreUsecase(this._drugstoreRepository, this._drugstoreMapper);

  @override
  Future<GetListDrugstoreOutput> buildUseCase(
      GetListDrugstoreInput input) async {
    try {
      final res = await _drugstoreRepository.getAllDrugstores(
        page: input.page,
        limit: input.limit,
        keySearch: input.search,
      );
      final dataEntity = _drugstoreMapper.mapToListEntity(res.data);
      return GetListDrugstoreOutput(BaseResponseModel<List<DrugstoreEntity>>(
        code: res.code,
        data: dataEntity,
        message: res.message,
        extra: res.extra,
      ));
    } catch (e) {
      return GetListDrugstoreOutput(BaseResponseModel<List<DrugstoreEntity>>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class GetListDrugstoreInput extends BaseInput {
  final int page;
  final int limit;
  final String? search;

  GetListDrugstoreInput({
    required this.page,
    required this.limit,
    this.search,
  });
}

class GetListDrugstoreOutput extends BaseOutput {
  final BaseResponseModel<List<DrugstoreEntity>> response;

  GetListDrugstoreOutput(this.response);
}
