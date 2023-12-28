import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/mapper/base/data_mapper.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/mapper/address_mapper.dart';
import 'package:pharmago_patient/presentation/views/drugstore/data/mapper/drugstore_mapper.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/mapper/order_count_mapper.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/models/order_model.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/data/mapper/variant_mapper.dart';

@injectable
class OrderMapper extends BaseDataMapper<OrderModel, OrderEntity> {
  final VariantMapper _variantMapper;
  final DrugstoreMapper _drugstoreMapper;
  final AddressMapper _addressMapper;
  final CountOrderMapper _countOrderMapper;

  OrderMapper(
    this._variantMapper,
    this._drugstoreMapper,
    this._addressMapper, 
    this._countOrderMapper,
  );
  @override
  OrderEntity mapToEntity(OrderModel? data) {
    return OrderEntity(
      id: data?.id,
      code: data?.code,
      workspace: data?.workspace != null
          ? _drugstoreMapper.mapToEntity(data?.workspace)
          : null,
      address: data?.address != null && num.tryParse(data!.address.toString()) != null ? data.address : null,
      addressData: data?.addressData != null
          ? _addressMapper.mapToEntity(data!.addressData)
          : null,
      account: data?.account,
      totalItem: data?.totalItem,
      totalCost: data?.totalCost,
      note: data?.note,
      status: data?.status != null
          ? _countOrderMapper.mapToEntity(data?.status)
          : null,
      items: data?.items != null && data!.items!.isNotEmpty
          ? data.items!
              .map((e) => OrderItemEntity(
                    variant: _variantMapper.mapToEntity(e.variant),
                    unit: e.unit,
                    quantity: e.quantity,
                    price: e.price,
                  ))
              .toList()
          : null,
    );
  }
}
