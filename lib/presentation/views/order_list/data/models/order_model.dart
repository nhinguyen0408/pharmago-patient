import 'dart:convert';

import 'package:pharmago_patient/presentation/views/product_list/data/models/variant_model.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final int? id;
  final String? code;
  final int? workspace;
  final int? address;
  final int? account;
  final int? totalItem;
  final int? totalCost;
  final List<OrderItem>? items;

  OrderModel({
    this.id,
    this.code,
    this.workspace,
    this.address,
    this.account,
    this.totalItem,
    this.totalCost,
    this.items,
  });

  OrderModel copyWith({
    int? id,
    String? code,
    int? workspace,
    int? address,
    int? account,
    int? totalItem,
    int? totalCost,
    List<OrderItem>? items,
  }) =>
      OrderModel(
        id: id ?? this.id,
        code: code ?? this.code,
        workspace: workspace ?? this.workspace,
        address: address ?? this.address,
        account: account ?? this.account,
        totalItem: totalItem ?? this.totalItem,
        totalCost: totalCost ?? this.totalCost,
        items: items ?? this.items,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'],
        code: json['code'],
        workspace: json['workspace'],
        address: json['address'],
        account: json['account'],
        totalItem: json['total_item'],
        totalCost: json['total_cost'],
        items: json['items'] == null
            ? []
            : List<OrderItem>.from(
                json['items']!.map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'workspace': workspace,
        'address': address,
        'account': account,
        'total_item': totalItem,
        'total_cost': totalCost,
        'items': items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class OrderItem {
  final VariantModel? variant;
  final Unit? unit;
  final int? quantity;
  final double? price;

  OrderItem({
    this.variant,
    this.unit,
    this.quantity,
    this.price,
  });

  OrderItem copyWith({
    VariantModel? variant,
    Unit? unit,
    int? quantity,
    double? price,
  }) =>
      OrderItem(
        variant: variant ?? this.variant,
        unit: unit ?? this.unit,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
      );

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        variant:
            json['variant'] == null ? null : VariantModel.fromJson(json['variant']),
        unit: json['unit'] == null ? null : Unit.fromJson(json['unit']),
        quantity: json['quantity'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'variant': variant?.toJson(),
        'unit': unit?.toJson(),
        'quantity': quantity,
        'price': price,
      };
}

class Unit {
  final int? id;
  final String? title;
  final int? weight;
  final dynamic weightUnit;

  Unit({
    this.id,
    this.title,
    this.weight,
    this.weightUnit,
  });

  Unit copyWith({
    int? id,
    String? title,
    int? weight,
    dynamic weightUnit,
  }) =>
      Unit(
        id: id ?? this.id,
        title: title ?? this.title,
        weight: weight ?? this.weight,
        weightUnit: weightUnit ?? this.weightUnit,
      );

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json['id'],
        title: json['title'],
        weight: json['weight'],
        weightUnit: json['weight_unit'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'weight': weight,
        'weight_unit': weightUnit,
      };
}