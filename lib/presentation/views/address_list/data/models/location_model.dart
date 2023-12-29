import 'dart:convert';

LocationModel locationModelFromJson(String str) => LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
    final int? id;
    final String? title;
    final String? code;

    LocationModel({
        this.id,
        this.title,
        this.code,
    });

    LocationModel copyWith({
        int? id,
        String? title,
        String? code,
    }) => 
        LocationModel(
            id: id ?? this.id,
            title: title ?? this.title,
            code: code ?? this.code,
        );

    factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json['id'],
        title: json['title'],
        code: json['code'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'code': code,
    };
}
