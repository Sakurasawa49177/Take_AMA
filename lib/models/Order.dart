// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.message,
    this.data,
  });

  String? message;
  OrderDetail? data;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        message: json["message"],
        data: OrderDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class OrderDetail {
  OrderDetail({
    this.id,
    this.date,
    this.careTaker,
    this.hours,
    this.price,
    this.amaName,
    this.orderStatus,
    this.amaLat,
    this.amaLong,
  });

  String? id;
  DateTime? date;
  String? careTaker;
  String? hours;
  String? price;
  String? amaName;
  String? orderStatus;
  double? amaLat;
  double? amaLong;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        careTaker: json["careTaker"],
        hours: json["hours"],
        price: json["price"],
        amaName: json["amaName"],
        orderStatus: json["orderStatus"],
        amaLat: double.parse(json["amaLat"] ?? 0),
        amaLong: double.parse(json["amaLong"] ?? 0),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date!.toIso8601String(),
        "careTaker": careTaker,
        "hours": hours,
        "price": price,
        "amaName": amaName,
        "orderStatus": orderStatus,
        "amaLat": amaLat,
        "amaLong": amaLong,
      };
}
