import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/mapper/base/data_mapper.dart';
import 'package:pharmago_patient/presentation/views/order_list/data/models/order_count_model.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_count_entity.dart';

@injectable
class CountOrderMapper extends BaseDataMapper<CountOrderModel, CountOrderEntity> {
  @override
  CountOrderEntity mapToEntity(CountOrderModel? data) {
    return CountOrderEntity(
      status: data?.status,
      count: data?.count,
      key: data?.key,
    );
  }
}
