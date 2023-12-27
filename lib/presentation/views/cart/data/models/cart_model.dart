import 'dart:convert';

import 'package:pharmago_patient/presentation/views/drugstore/data/models/drugstore_model.dart';
import 'package:pharmago_patient/presentation/views/product_list/data/models/variant_model.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    final int? id;
    final int? quantity;
    final UnitModel? unit;
    final VariantModel? variant;
    final DrugstoreModel? drugstore;

    CartModel({
        this.id,
        this.quantity,
        this.unit,
        this.variant,
        this.drugstore,
    });

    CartModel copyWith({
        int? id,
        int? quantity,
        UnitModel? unit,
        VariantModel? variant,
        DrugstoreModel? drugstore,
    }) => 
        CartModel(
            id: id ?? this.id,
            quantity: quantity ?? this.quantity,
            unit: unit ?? this.unit,
            variant: variant ?? this.variant,
            drugstore: drugstore ?? this.drugstore,
        );

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        quantity: json["quantity"],
        unit: json["unit"] == null ? null : UnitModel.fromJson(json['unit']),
        variant: json["variant"] == null ? null : VariantModel.fromJson(json["variant"]),
        drugstore: json["workspace"] == null ? null : DrugstoreModel.fromJson(json["workspace"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "unit": unit,
        "variant": variant?.toJson(),
        "workspace": drugstore?.toJson(),
    };
}
