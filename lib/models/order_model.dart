import 'dart:convert';

import 'package:meal/providers/shopping_cart_provider.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.idOrder,
    this.idUser,
    this.status,
    this.date,
    this.productsInCartList,
    this.direction,
    this.typeDelivery,
    this.contactNumber,
    this.comments,
    this.paymentType,
    this.price,
    this.nameClient,
  });

  String idOrder;
  String idUser;
  String status;
  String date;
  List<ShoppingCartModel> productsInCartList;
  String direction;
  String typeDelivery;
  int contactNumber;
  String comments;
  String paymentType;
  String price;
  String nameClient;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        idOrder: json["idOrder"],
        idUser: json["idUser"],
        status: json["status"],
        date: json["date"],
        productsInCartList: List<ShoppingCartModel>.from(
            json["productsInCartList"]
                .map((x) => ShoppingCartModel.fromJson(x))),
        direction: json["direction"],
        typeDelivery: json["typeDelivery"],
        contactNumber: json["contactNumber"],
        comments: json["comments"],
        paymentType: json["paymentType"],
        price: json["price"],
        nameClient: json["nameClient"],
      );

  Map<String, dynamic> toJson() => {
        "idOrder": idOrder,
        "idUser": idUser,
        "status": status,
        "date": date,
        "productsInCartList":
            List<dynamic>.from(productsInCartList.map((x) => x.toJson())),
        "direction": direction,
        "typeDelivery": typeDelivery,
        "contactNumber": contactNumber,
        "comments": comments,
        "paymentType": paymentType,
        "price": price,
        "nameClient": nameClient,
      };
}

class ProductsInCartList {
  ProductsInCartList();

  factory ProductsInCartList.fromJson(Map<String, dynamic> json) =>
      ProductsInCartList();

  Map<String, dynamic> toJson() => {};
}
