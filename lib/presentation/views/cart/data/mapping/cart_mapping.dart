import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/mapper/base/data_mapper.dart';
import 'package:pharmago_patient/presentation/views/cart/data/models/cart_model.dart';
import 'package:pharmago_patient/presentation/views/cart/domain/entities/cart_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';

@injectable
class CartMapping extends BaseDataMapper<CartModel, CartEntity> {
  @override
  CartEntity mapToEntity(CartModel? data) {
    return CartEntity(
      id: data?.id,
      quantity: data?.quantity,
      unit: UnitEntity(
        id: data?.unit?.id,
        title: data?.unit?.title,
      ),
      variant: VariantEntity(
        title: data?.variant?.title,
        image: data?.variant?.image,
        price: data?.variant?.price,
        id: data?.variant?.id,
      ),
    );
  }
}
