import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/domain/usecase/base/future_use_case.dart';
import 'package:pharmago_patient/domain/usecase/base/io/input.dart';
import 'package:pharmago_patient/domain/usecase/base/io/output.dart';
import 'package:pharmago_patient/presentation/views/product_list/data/mapper/product_mapper.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/product_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/repositories/product_repository.dart';

@injectable
class GetListProductUsecase
    extends BaseFutureUseCase<GetListProductInput, GetListProductOutput> {
  final ProductRepository _productRepository;
  final ProductMapper _productMapper;
  GetListProductUsecase(this._productRepository, this._productMapper);

  @override
  Future<GetListProductOutput> buildUseCase(
      GetListProductInput input) async {
    try {
      final res = await _productRepository.getListProducts(
        page: input.page,
        limit: input.limit,
        keySearch: input.search,
      );
      final dataEntity = _productMapper.mapToListEntity(res.data);
      return GetListProductOutput(BaseResponseModel<List<ProductEntity>>(
        code: res.code,
        data: dataEntity,
        message: res.message,
        extra: res.extra,
      ));
    } catch (e) {
      return GetListProductOutput(BaseResponseModel<List<ProductEntity>>(
        code: 400,
        message: e.toString(),
      ));
    }
  }
}

class GetListProductInput extends BaseInput {
  final int page;
  final int limit;
  final String? search;
  final String? orderBy;
  final String? drugstore;

  GetListProductInput({
    required this.page,
    required this.limit,
    this.search,
    this.orderBy, 
    this.drugstore,
  });
}

class GetListProductOutput extends BaseOutput {
  final BaseResponseModel<List<ProductEntity>> response;

  GetListProductOutput(this.response);
}
