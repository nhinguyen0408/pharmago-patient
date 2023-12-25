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
    final String? description;
    final bool? active;
    final List<UnitModel>? units;
    final dynamic addition;

    VariantModel({
        this.id,
        this.capitalPrice,
        this.price,
        this.title,
        this.description,
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
        String? description,
        bool? active,
        List<UnitModel>? units,
        dynamic addition,
    }) => 
        VariantModel(
            id: id ?? this.id,
            capitalPrice: capitalPrice ?? this.capitalPrice,
            price: price ?? this.price,
            sku: sku ?? this.sku,
            image: image ?? this.image,
            title: title ?? this.title,
            description: description ?? this.description,
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
        units: json['units'] == null ? [] : List<UnitModel>.from(json['units']!.map((x) => UnitModel.fromJson(x))),
        addition: json['addition'],
        title: json['title'],
        description: json['description'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'capital_price': capitalPrice,
        'price': price,
        'sku': sku,
        'image': image,
        'active': active,
        'units': units == null ? [] : List<UnitModel>.from(units!.map((x) => x.toJson())),
        'addition': addition,
        'title': title,
        'description': description,
    };
}

class UnitModel {
    final int? id;
    final String? timeCreated;
    final String? timeUpdated;
    final String? title;
    final double? capitalPrice;
    final double? price;
    final int? weight;
    final dynamic weightUnit;
    final bool? classic;
    final dynamic createdBy;
    final dynamic updatedBy;

    UnitModel({
        this.id,
        this.timeCreated,
        this.timeUpdated,
        this.title,
        this.capitalPrice,
        this.price,
        this.weight,
        this.weightUnit,
        this.classic,
        this.createdBy,
        this.updatedBy,
    });

    UnitModel copyWith({
        int? id,
        String? timeCreated,
        String? timeUpdated,
        String? title,
        double? capitalPrice,
        double? price,
        int? weight,
        dynamic weightUnit,
        bool? classic,
        dynamic createdBy,
        dynamic updatedBy,
    }) => 
        UnitModel(
            id: id ?? this.id,
            timeCreated: timeCreated ?? this.timeCreated,
            timeUpdated: timeUpdated ?? this.timeUpdated,
            title: title ?? this.title,
            capitalPrice: capitalPrice ?? this.capitalPrice,
            price: price ?? this.price,
            weight: weight ?? this.weight,
            weightUnit: weightUnit ?? this.weightUnit,
            classic: classic ?? this.classic,
            createdBy: createdBy ?? this.createdBy,
            updatedBy: updatedBy ?? this.updatedBy,
        );

    factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        id: json["id"],
        timeCreated: json["time_created"],
        timeUpdated: json["time_updated"],
        title: json["title"],
        capitalPrice: json["capital_price"],
        price: json["price"],
        weight: json["weight"],
        weightUnit: json["weight_unit"],
        classic: json["classic"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "time_created": timeCreated,
        "time_updated": timeUpdated,
        "title": title,
        "capital_price": capitalPrice,
        "price": price,
        "weight": weight,
        "weight_unit": weightUnit,
        "classic": classic,
        "created_by": createdBy,
        "updated_by": updatedBy,
    };
}
