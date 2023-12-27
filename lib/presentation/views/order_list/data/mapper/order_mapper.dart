import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/mapper/base/data_mapper.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/models/order_model.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/data/mapper/variant_mapper.dart';

@injectable
class OrderMapper extends BaseDataMapper<OrderModel, OrderEntity> {
  final VariantMapper _variantMapper;

  OrderMapper(this._variantMapper);
  @override
  OrderEntity mapToEntity(OrderModel? data) {
    return OrderEntity(
      id: data?.id,
      code: data?.code,
      workspace: data?.workspace,
      address: data?.address,
      account: data?.account,
      totalItem: data?.totalItem,
      totalCost: data?.totalCost,
      items: data?.items != null && data!.items!.isNotEmpty
          ? data.items!.map((e) => OrderItemEntity(
              variant: _variantMapper.mapToEntity(e.variant),
              unit: e.unit,
              quantity: e.quantity,
              price: e.price,
          )).toList()
          : null,
    );
  }
}
