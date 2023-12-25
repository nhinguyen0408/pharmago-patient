import 'dart:convert';

CartPayloadModel cartPayloadModelFromJson(String str) => CartPayloadModel.fromJson(json.decode(str));

String cartPayloadModelToJson(CartPayloadModel data) => json.encode(data.toJson());

class CartPayloadModel {
    final int? variant;
    final int? unit;
    final int? quantity;

    CartPayloadModel({
        this.variant,
        this.unit,
        this.quantity,
    });

    CartPayloadModel copyWith({
        int? variant,
        int? unit,
        int? quantity,
    }) => 
        CartPayloadModel(
            variant: variant ?? this.variant,
            unit: unit ?? this.unit,
            quantity: quantity ?? this.quantity,
        );

    factory CartPayloadModel.fromJson(Map<String, dynamic> json) => CartPayloadModel(
        variant: json["variant"],
        unit: json["unit"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "variant": variant,
        "unit": unit,
        "quantity": quantity,
    };
}
