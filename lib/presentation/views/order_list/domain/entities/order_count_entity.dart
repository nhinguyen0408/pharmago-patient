
import 'package:freezed_annotation/freezed_annotation.dart';
part 'order_count_entity.freezed.dart';

@freezed
class CountOrderEntity with _$CountOrderEntity {
  const factory CountOrderEntity({
    String? status,
    int? count,
    int? key,
  }) = _CountOrderEntity;
}