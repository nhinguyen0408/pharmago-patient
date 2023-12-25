import 'dart:convert';

VariantModel variantModelFromJson(String str) => VariantModel.fromJson(json.decode(str));

String variantModelToJson(VariantModel data) => json.encode(data.toJson());

class VariantModel {
    final int? id;
    final double? capitalPrice;
    final double? price;
    final dynamic sku;
    final String? image;
    final String? title;
    final bool? active;
    final List<dynamic>? units;
    final dynamic addition;

    VariantModel({
        this.id,
        this.capitalPrice,
        this.price,
        this.title,
        this.sku,
        this.image,
        this.active,
        this.units,
        this.addition,
    });

    VariantModel copyWith({
        int? id,
        double? capitalPrice,
        double? price,
        dynamic sku,
        String? image,
        String? title,
        bool? active,
        List<dynamic>? units,
        dynamic addition,
    }) => 
        VariantModel(
            id: id ?? this.id,
            capitalPrice: capitalPrice ?? this.capitalPrice,
            price: price ?? this.price,
            sku: sku ?? this.sku,
            image: image ?? this.image,
            title: title ?? this.title,
            active: active ?? this.active,
            units: units ?? this.units,
            addition: addition ?? this.addition,
        );

    factory VariantModel.fromJson(Map<String, dynamic> json) => VariantModel(
        id: json['id'],
        capitalPrice: json['capital_price'],
        price: json['price'],
        sku: json['sku'],
        image: json['image'],
        active: json['active'],
        units: json['units'] == null ? [] : List<dynamic>.from(json['units']!.map((x) => x)),
        addition: json['addition'],
        title: json['title'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'capital_price': capitalPrice,
        'price': price,
        'sku': sku,
        'image': image,
        'active': active,
        'units': units == null ? [] : List<dynamic>.from(units!.map((x) => x)),
        'addition': addition,
        'title': title,
    };
}
