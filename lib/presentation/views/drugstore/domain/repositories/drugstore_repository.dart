import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/drugstore/data/models/drugstore_model.dart';

abstract class DrugstoreRepository {
  Future<BaseResponseModel<List<DrugstoreModel>>> getAllDrugstores({
    required int? page,
    required int? limit,
    String? keySearch,
  });
}