import 'dart:convert';

PersionalProfileModel persionalProfileModelFromJson(String str) => PersionalProfileModel.fromJson(json.decode(str));

String persionalProfileModelToJson(PersionalProfileModel data) => json.encode(data.toJson());

class PersionalProfileModel {
    final int? id;
    final String? code;
    final String? username;
    final bool? verified;
    final String? fullname;
    final String? phone;
    final String? email;
    final DateTime? dateJoined;

    PersionalProfileModel({
        this.id,
        this.code,
        this.username,
        this.verified,
        this.fullname,
        this.phone,
        this.email,
        this.dateJoined,
    });

    PersionalProfileModel copyWith({
        int? id,
        String? code,
        String? username,
        bool? verified,
        String? fullname,
        String? phone,
        String? email,
        DateTime? dateJoined,
    }) => 
        PersionalProfileModel(
            id: id ?? this.id,
            code: code ?? this.code,
            username: username ?? this.username,
            verified: verified ?? this.verified,
            fullname: fullname ?? this.fullname,
            phone: phone ?? this.phone,
            email: email ?? this.email,
            dateJoined: dateJoined ?? this.dateJoined,
        );

    factory PersionalProfileModel.fromJson(Map<String, dynamic> json) => PersionalProfileModel(
        id: json['id'],
        code: json['code'],
        username: json['username'],
        verified: json['verified'],
        fullname: json['fullname'],
        phone: json['phone'],
        email: json['email'],
        dateJoined: json['date_joined'] == null ? null : DateTime.parse(json['date_joined']),
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'username': username,
        'verified': verified,
        'fullname': fullname,
        'phone': phone,
        'email': email,
        'date_joined': dateJoined?.toIso8601String(),
    };
}
