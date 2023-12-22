import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/product_list/data/models/product_model.dart';

abstract class ProductRepository {
  Future<BaseResponseModel<List<ProductModel>>> getListProducts({
    required int? page,
    required int? limit,
    String? keySearch,
    String? orderBy,
    String? workspace,
  });
}