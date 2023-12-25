import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/product_list/data/mapper/variant_mapper.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/repositories/variant_repository.dart';

@injectable
class GetListVariantUsecase
    extends BaseFutureUseCase<GetListVariantInput, GetListVariantOutput> {
  final VariantRepository _variantRepository;
  final VariantMapper _variantMapper;
  GetListVariantUsecase(this._variantRepository, this._variantMapper);

  @override
  Future<GetListVariantOutput> buildUseCase(
      GetListVariantInput input) async {
    try {
      final res = await _variantRepository.getListVariants(
        page: input.page.toString(),
        limit: input.limit.toString(),
        search: input.search,
        drugstore: input.drugstore,
      );
      final dataEntity = _variantMapper.mapToListEntity(res.data);
      return GetListVariantOutput(BaseResponseModel<List<VariantEntity>>(
        code: res.code,
        data: dataEntity,
        message: res.message,
        extra: res.extra,
      ));
    } catch (e) {
      return GetListVariantOutput(BaseResponseModel<List<VariantEntity>>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class GetListVariantInput extends BaseInput {
  final int page;
  final int limit;
  final String? search;
  final String? orderBy;
  final String drugstore;

  GetListVariantInput({
    required this.page,
    required this.limit,
    this.search,
    this.orderBy, 
    required this.drugstore,
  });
}

class GetListVariantOutput extends BaseOutput {
  final BaseResponseModel<List<VariantEntity>> response;

  GetListVariantOutput(this.response);
}
