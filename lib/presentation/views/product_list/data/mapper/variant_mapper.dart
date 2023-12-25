import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/mapper/base/data_mapper.dart';
import 'package:pharmago_patient/presentation/views/product_list/data/models/variant_model.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';

@injectable
class VariantMapper extends BaseDataMapper<VariantModel, VariantEntity> {
  @override
  VariantEntity mapToEntity(VariantModel? data) {
    return VariantEntity(
        id: data?.id,
        capitalPrice: data?.capitalPrice,
        price: data?.price,
        sku: data?.sku,
        image: data?.image,
        active: data?.active,
        units: data?.units,
        addition: data?.addition,
        title: data?.title,
    );
  }
}