import 'dart:convert';

AddressPayloadModel addressPayloadModelFromJson(String str) =>
    AddressPayloadModel.fromJson(json.decode(str));

String addressPayloadModelToJson(AddressPayloadModel data) =>
    json.encode(data.toJson());

class AddressPayloadModel {
  final String? fullName;
  final String? phone;
  final bool? addressPayloadModelDefault;
  final int? province;
  final int? district;
  final int? ward;
  final double? lat;
  final double? long;
  final String? title;
  final String? provinceName;
  final String? districtName;
  final String? wardName;

  AddressPayloadModel({
    this.fullName,
    this.phone,
    this.addressPayloadModelDefault,
    this.province,
    this.district,
    this.ward,
    this.lat,
    this.long,
    this.title,
    this.provinceName,
    this.districtName,
    this.wardName,
  });

  AddressPayloadModel copyWith({
    String? fullName,
    String? phone,
    bool? addressPayloadModelDefault,
    int? province,
    int? district,
    int? ward,
    double? lat,
    double? long,
    String? title,
    String? provinceName,
    String? districtName,
    String? wardName,
  }) =>
      AddressPayloadModel(
        fullName: fullName ?? this.fullName,
        phone: phone ?? this.phone,
        addressPayloadModelDefault:
            addressPayloadModelDefault ?? this.addressPayloadModelDefault,
        province: province ?? this.province,
        district: district ?? this.district,
        ward: ward ?? this.ward,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        title: title ?? this.title,
        provinceName: provinceName ?? this.provinceName,
        districtName: districtName ?? this.districtName,
        wardName: wardName ?? this.wardName,
      );

  factory AddressPayloadModel.fromJson(Map<String, dynamic> json) =>
      AddressPayloadModel(
        fullName: json["full_name"],
        phone: json["phone"],
        addressPayloadModelDefault: json["default"],
        province: json["province"],
        district: json["district"],
        ward: json["ward"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "phone": phone,
        "default": addressPayloadModelDefault,
        "province": province,
        "district": district,
        "ward": ward,
        "lat": lat,
        "long": long,
        "title": title,
      };
}
