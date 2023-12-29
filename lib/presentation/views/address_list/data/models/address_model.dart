import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  final int? id;
  final TitleModel? province;
  final TitleModel? district;
  final TitleModel? ward;
  final String? fullName;
  final String? phone;
  final bool? isDefault;
  final String? title;
  final double? lat;
  final double? long;
  final String? createdAt;
  final String? updatedAt;
  final int? account;

  AddressModel({
    this.id,
    this.province,
    this.district,
    this.ward,
    this.fullName,
    this.phone,
    this.isDefault,
    this.title,
    this.lat,
    this.long,
    this.createdAt,
    this.updatedAt,
    this.account,
  });

  AddressModel copyWith({
    int? id,
    TitleModel? province,
    TitleModel? district,
    TitleModel? ward,
    String? fullName,
    String? phone,
    bool? isDefault,
    String? title,
    double? lat,
    double? long,
    String? createdAt,
    String? updatedAt,
    int? account,
  }) =>
      AddressModel(
        id: id ?? this.id,
        province: province ?? this.province,
        district: district ?? this.district,
        ward: ward ?? this.ward,
        fullName: fullName ?? this.fullName,
        phone: phone ?? this.phone,
        isDefault: isDefault ?? this.isDefault,
        title: title ?? this.title,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        account: account ?? this.account,
      );

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'],
        province: json['province'] == null
            ? null
            : TitleModel.fromJson(json['province']),
        district: json['district'] == null
            ? null
            : TitleModel.fromJson(json['district']),
        ward: json['ward'] == null ? null : TitleModel.fromJson(json['ward']),
        fullName: json['full_name'],
        phone: json['phone'],
        isDefault: json['default'],
        title: json['title'],
        lat: json['lat'],
        long: json['long'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        account: json['account'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'province': province?.toJson(),
        'district': district?.toJson(),
        'ward': ward?.toJson(),
        'full_name': fullName,
        'phone': phone,
        'default': isDefault,
        'title': title,
        'lat': lat,
        'long': long,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'account': account,
      };
}

class TitleModel {
  final String? title;
  final String? provinceCode;
  final String? districtCode;
  final String? wardCode;
  final String? code;

  TitleModel({
    this.title,
    this.provinceCode,
    this.code,
    this.districtCode,
    this.wardCode,
  });

  TitleModel copyWith({
    String? title,
    dynamic provinceCode,
    String? code,
    String? districtCode,
    String? wardCode,
  }) =>
      TitleModel(
        title: title ?? this.title,
        provinceCode: provinceCode ?? this.provinceCode,
        districtCode: districtCode ?? this.districtCode,
        wardCode: wardCode ?? this.wardCode,
        code: code ?? this.code,
      );

  factory TitleModel.fromJson(Map<String, dynamic> json) => TitleModel(
        title: json['title'],
        provinceCode: json['province_code'],
        districtCode: json['district_code'],
        wardCode: json['ward_code'],
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'province_code': provinceCode,
        'district_code': districtCode,
        'ward_code': wardCode,
        'code': code,
      };
}
