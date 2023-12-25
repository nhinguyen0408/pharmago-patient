import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/product_list/data/models/variant_model.dart';

abstract class VariantRepository {
  Future<BaseResponseModel<List<VariantModel>>> getListVariants({
    required String drugstore,
    String? search,
    String? limit,
    String? page,
    DateTime? createdFrom,
    DateTime? createdTo,
  });

  Future<BaseResponseModel<VariantModel>> getDetailVariant({
    String? id,
  });
}