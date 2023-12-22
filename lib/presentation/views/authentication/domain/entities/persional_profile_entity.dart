import 'package:freezed_annotation/freezed_annotation.dart';
part 'persional_profile_entity.freezed.dart';

@freezed
class PersionalProfileEntity with _$PersionalProfileEntity {
  const factory PersionalProfileEntity({
    int? id,
    String? code,
    String? username,
    bool? verified,
    String? fullname,
    String? phone,
    String? email,
    DateTime? dateJoined,
  }) = _PersionalProfileEntity;
}