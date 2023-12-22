import 'dart:convert';

DrugstoreModel drugstoreModelFromJson(String str) =>
    DrugstoreModel.fromJson(json.decode(str));

String drugstoreModelToJson(DrugstoreModel data) => json.encode(data.toJson());

class DrugstoreModel {
  final int? id;
  final String? code;
  final String? name;
  final String? address;
  final DateTime? timeCreated;
  final DateTime? timeUpdated;
  final dynamic createdBy;
  final dynamic updatedBy;
  final double? lat;
  final double? long;

  DrugstoreModel({
    this.id,
    this.code,
    this.name,
    this.address,
    this.timeCreated,
    this.timeUpdated,
    this.createdBy,
    this.updatedBy,
    this.lat,
    this.long,
  });

  DrugstoreModel copyWith({
    int? id,
    String? code,
    String? name,
    String? address,
    DateTime? timeCreated,
    DateTime? timeUpdated,
    dynamic createdBy,
    dynamic updatedBy,
    double? lat,
    double? long,
  }) =>
      DrugstoreModel(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        address: address ?? this.address,
        timeCreated: timeCreated ?? this.timeCreated,
        timeUpdated: timeUpdated ?? this.timeUpdated,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        lat: lat ?? this.lat,
        long: long ?? this.long,
      );

  factory DrugstoreModel.fromJson(Map<String, dynamic> json) => DrugstoreModel(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        address: json["address"],
        timeCreated: json["time_created"] == null
            ? null
            : DateTime.parse(json["time_created"]),
        timeUpdated: json["time_updated"] == null
            ? null
            : DateTime.parse(json["time_updated"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "address": address,
        "time_created": timeCreated?.toIso8601String(),
        "time_updated": timeUpdated?.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "lat": lat,
        "long": long,
      };
}
