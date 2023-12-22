import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/mapper/base/data_mapper.dart';
import 'package:pharmago_patient/presentation/views/drugstore/data/models/drugstore_model.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';

@injectable
class DrugstoreMapper extends BaseDataMapper<DrugstoreModel, DrugstoreEntity> {
  @override
  DrugstoreEntity mapToEntity(DrugstoreModel? data) {
    return DrugstoreEntity(
      id: data?.id,
      code: data?.code,
      name: data?.name,
      address: data?.address,
      timeCreated: data?.timeCreated,
      timeUpdated: data?.timeUpdated,
      createdBy: data?.createdBy,
      updatedBy: data?.updatedBy,
      lat: data?.lat,
      long: data?.long,
    );
  }

}