import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/address_model.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/payload/address_payload_model.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';

abstract class AddressRepository {
  Future<BaseResponseModel<List<AddressModel>>> getAllAddress();
  Future<BaseResponseModel<AddressModel?>> setAddressDefault(AddressEntity address);
  Future<BaseResponseModel<AddressModel?>> createAddress({ required AddressPayloadModel address });
  Future<BaseResponseModel<AddressModel?>> updateAddress({ required AddressPayloadModel address, required int id });
}