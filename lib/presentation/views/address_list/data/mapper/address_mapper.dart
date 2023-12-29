import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/mapper/base/data_mapper.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/address_model.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';

@injectable
class AddressMapper extends BaseDataMapper<AddressModel, AddressEntity> {
  @override
  AddressEntity mapToEntity(AddressModel? data) {
    return AddressEntity(
      id: data?.id,
      province: data?.province,
      district: data?.district,
      ward: data?.ward,
      fullName: data?.fullName,
      phone: data?.phone,
      isDefault: data?.isDefault,
      title: data?.title,
      lat: data?.lat,
      long: data?.long,
      createdAt: data?.createdAt,
      updatedAt: data?.updatedAt,
      account: data?.account,
    );
  }

}