import 'dart:convert';

import 'package:pharmago_patient/presentation/views/product_list/data/models/variant_model.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    final int? id;
    final int? quantity;
    final String? unit;
    final VariantModel? variant;

    CartModel({
        this.id,
        this.quantity,
        this.unit,
        this.variant,
    });

    CartModel copyWith({
        int? id,
        int? quantity,
        String? unit,
        VariantModel? variant,
    }) => 
        CartModel(
            id: id ?? this.id,
            quantity: quantity ?? this.quantity,
            unit: unit ?? this.unit,
            variant: variant ?? this.variant,
        );

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        quantity: json["quantity"],
        unit: json["unit"],
        variant: json["variant"] == null ? null : VariantModel.fromJson(json["variant"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "unit": unit,
        "variant": variant?.toJson(),
    };
}
