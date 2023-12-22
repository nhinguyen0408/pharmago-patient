// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    final int? id;
    final String? title;
    final String? code;
    final int? workspace;
    final String? image;
    final String? description;
    final dynamic brand;
    final dynamic category;
    final dynamic productType;
    final dynamic productAttributes;
    final dynamic createdBy;
    final DateTime? timeCreated;
    final DateTime? timeUpdated;
    final bool? imported;

    ProductModel({
        this.id,
        this.title,
        this.code,
        this.workspace,
        this.image,
        this.description,
        this.brand,
        this.category,
        this.productType,
        this.productAttributes,
        this.createdBy,
        this.timeCreated,
        this.timeUpdated,
        this.imported,
    });

    ProductModel copyWith({
        int? id,
        String? title,
        String? code,
        int? workspace,
        String? image,
        String? description,
        dynamic brand,
        dynamic category,
        dynamic productType,
        dynamic productAttributes,
        dynamic createdBy,
        DateTime? timeCreated,
        DateTime? timeUpdated,
        bool? imported,
    }) => 
        ProductModel(
            id: id ?? this.id,
            title: title ?? this.title,
            code: code ?? this.code,
            workspace: workspace ?? this.workspace,
            image: image ?? this.image,
            description: description ?? this.description,
            brand: brand ?? this.brand,
            category: category ?? this.category,
            productType: productType ?? this.productType,
            productAttributes: productAttributes ?? this.productAttributes,
            createdBy: createdBy ?? this.createdBy,
            timeCreated: timeCreated ?? this.timeCreated,
            timeUpdated: timeUpdated ?? this.timeUpdated,
            imported: imported ?? this.imported,
        );

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        title: json['title'],
        code: json['code'],
        workspace: json['workspace'],
        image: json['image'],
        description: json['description'],
        brand: json['brand'],
        category: json['category'],
        productType: json['product_type'],
        productAttributes: json['product_attributes'],
        createdBy: json['created_by'],
        timeCreated: json['time_created'] == null ? null : DateTime.parse(json['time_created']),
        timeUpdated: json['time_updated'] == null ? null : DateTime.parse(json['time_updated']),
        imported: json['imported'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'code': code,
        'workspace': workspace,
        'image': image,
        'description': description,
        'brand': brand,
        'category': category,
        'product_type': productType,
        'product_attributes': productAttributes,
        'created_by': createdBy,
        'time_created': timeCreated?.toIso8601String(),
        'time_updated': timeUpdated?.toIso8601String(),
        'imported': imported,
    };
}
