import 'package:pharmago_patient/data/mapper/base/data_mapper.dart';
import 'package:pharmago_patient/presentation/views/product_list/data/models/product_model.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/product_entity.dart';

class ProductMapper extends BaseDataMapper<ProductModel, ProductEntity>{
  @override
  ProductEntity mapToEntity(ProductModel? data) {
    return ProductEntity(
      id: data?.id,
      title: data?.title,
      code: data?.code,
      workspace: data?.workspace,
      image: data?.image,
      description: data?.description,
      brand: data?.brand,
      category: data?.category,
      productType: data?.productType,
      productAttributes: data?.productAttributes,
      createdBy: data?.createdBy,
      timeCreated: data?.timeCreated,
      timeUpdated: data?.timeUpdated,
      imported: data?.imported,
    );
  }
}