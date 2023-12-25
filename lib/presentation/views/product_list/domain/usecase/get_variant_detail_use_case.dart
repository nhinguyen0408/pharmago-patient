import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/product_list/data/mapper/variant_mapper.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/repositories/variant_repository.dart';

@injectable
class GetDetailVariantUsecase
    extends BaseFutureUseCase<GetDetailVariantInput, GetDetailVariantOutput> {
  final VariantRepository _variantRepository;
  final VariantMapper _variantMapper;
  GetDetailVariantUsecase(this._variantRepository, this._variantMapper);

  @override
  Future<GetDetailVariantOutput> buildUseCase(
      GetDetailVariantInput input) async {
    try {
      final res = await _variantRepository.getDetailVariant(
        id: input.id,
      );
      final dataEntity = _variantMapper.mapToEntity(res.data);
      return GetDetailVariantOutput(BaseResponseModel<VariantEntity>(
        code: res.code,
        data: dataEntity, 
        message: res.message,
      ));
    } catch (e) {
      return GetDetailVariantOutput(BaseResponseModel<VariantEntity>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class GetDetailVariantInput extends BaseInput {
  final String id;

  GetDetailVariantInput({
    required this.id,
  });
}

class GetDetailVariantOutput extends BaseOutput {
  final BaseResponseModel<VariantEntity> response;

  GetDetailVariantOutput(this.response);
}
