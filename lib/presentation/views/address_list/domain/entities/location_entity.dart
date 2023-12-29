import 'package:freezed_annotation/freezed_annotation.dart';
part 'location_entity.freezed.dart';
@freezed
class LocationEntity with _$LocationEntity {
  const factory LocationEntity({
    int? id,
    String? title,
    String? code,
  }) = _LocationEntity;
}