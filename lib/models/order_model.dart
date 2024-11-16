// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:convert';

import 'package:saree/models/store_model.dart';

class OrderModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final LocationOrderModel location;
  final List<ProductOrderModel> products;
  final int products_amount;
  final int after_discount;
  final int delivery_cost;
  final int total_amount;
  final String status;
  final int user_id;
  final int store_id;
  final int? delivery_employee_id;
  final bool delivery_status;
  final bool is_delivered;
  final String notes;
  final DateTime? created_at;
  final StoreModel store;

  OrderModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.location,
    required this.products,
    required this.products_amount,
    required this.after_discount,
    required this.delivery_cost,
    required this.total_amount,
    required this.status,
    required this.user_id,
    required this.store_id,
    required this.delivery_employee_id,
    required this.delivery_status,
    required this.is_delivered,
    required this.notes,
    this.created_at,
    required this.store,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> location = jsonDecode(json["location"]);
    final List products = jsonDecode(json["products"]);
    return OrderModel(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      address: json["address"],
      location: LocationOrderModel.fromJson(location),
      products:
          List.of(products).map((e) => ProductOrderModel.fromJson(e)).toList(),
      products_amount: json["products_amount"],
      after_discount: json["after_discount"],
      delivery_cost: json["delivery_cost"],
      total_amount: json["total_amount"],
      status: json["status"],
      user_id: json["user_id"],
      store_id: json["store_id"],
      delivery_employee_id: json["delivery_employee_id"],
      delivery_status: json["delivery_status"] == 1,
      is_delivered: json["is_delivered"] == 1,
      notes: json["notes"] ?? "",
      created_at: DateTime.tryParse(json["created_at"]),
      store: StoreModel.fromJson(json["store"]),
    );
  }

  @override
  String toString() {
    return 'OrderModel{id: $id, name: $name, phone: $phone, address: $address, location: $location, products: $products, products_amount: $products_amount, after_discount: $after_discount, delivery_cost: $delivery_cost, total_amount: $total_amount, status: $status, user_id: $user_id, store_id: $store_id, delivery_employee_id: $delivery_employee_id, delivery_status: $delivery_status, is_delivered: $is_delivered, notes: $notes, store: $store}';
  }
//
}

class LocationOrderModel {
  final double lat;
  final double lng;

  LocationOrderModel({
    required this.lat,
    required this.lng,
  });

  factory LocationOrderModel.fromJson(Map<String, dynamic> json) {
    return LocationOrderModel(
      lat: json["lat"],
      lng: json["lng"],
    );
  }
}

class ProductOrderModel {
  final int product_id;
  final String product_name;
  final double product_price;
  final int product_quntity;
  final double product_total;

  factory ProductOrderModel.fromJson(Map<String, dynamic> json) {
    return ProductOrderModel(
      product_id: json["product_id"],
      product_name: json["product_name"],
      product_price: double.parse(json["product_price"].toString()),
      product_quntity: json["product_quntity"],
      product_total: double.parse(json["product_total"].toString()),
    );
  }

  ProductOrderModel({
    required this.product_id,
    required this.product_name,
    required this.product_price,
    required this.product_quntity,
    required this.product_total,
  });
}

int orderStateToInt(String orderState) {
  switch (orderState) {
    case OrderStates.INITIAL_ORDER_STATUS:
      return 2;
    case OrderStates.WITH_EMPLOYEE:
      return 2;
    case OrderStates.DESTINATION_REACHED:
      return 3;
    case OrderStates.ORDER_DELIVERED:
      return 4;
    default:
      return -1;
  }
}

class OrderStates {
  static const INITIAL_ORDER_STATUS = "قيد التجهيز";

  // first part of the order life cycle
  static const WITH_EMPLOYEE = "مع موظف التوصيل";

  // second part of the order life cycle
  static const DESTINATION_REACHED = "وصل الموظف إلى الوجهة";

  // third part of the order life cycle
  static const ORDER_DELIVERED = "تم التسليم";
}
