// To parse this JSON data, do
//
//     final statusModel = statusModelFromJson(jsonString);

import 'dart:convert';

CountOrderModel statusModelFromJson(String str) =>
    CountOrderModel.fromJson(json.decode(str));

String statusModelToJson(CountOrderModel data) => json.encode(data.toJson());

class CountOrderModel {
  final String? status;
  final int? count;
  final int? key;

  CountOrderModel({
    this.status,
    this.count,
    this.key,
  });

  CountOrderModel copyWith({
    String? status,
    int? count,
    int? key,
  }) =>
      CountOrderModel(
        status: status ?? this.status,
        count: count ?? this.count,
        key: key ?? this.key,
      );

  factory CountOrderModel.fromJson(Map<String, dynamic> json) => CountOrderModel(
        status: json["status"],
        count: json["count"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
        "key": key,
      };
}
