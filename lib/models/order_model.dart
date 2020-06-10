import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.idOrder,
    this.idUser,
    this.status,
    this.username,
    this.productsInCartList,
    this.direction,
    this.typeDelivery,
    this.contactNumber,
    this.comments,
    this.paymentType,
  });

  String idOrder;
  String idUser;
  String status;
  String username;
  List<String> productsInCartList;
  String direction;
  String typeDelivery;
  int contactNumber;
  String comments;
  String paymentType;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        idOrder: json["idOrder"],
        idUser: json["idUser"],
        status: json["status"],
        username: json["username"],
        productsInCartList:
            List<String>.from(json["productsInCartList"].map((x) => x)),
        direction: json["direction"],
        typeDelivery: json["typeDelivery"],
        contactNumber: json["contactNumber"],
        comments: json["comments"],
        paymentType: json["paymentType"],
      );

  Map<String, dynamic> toJson() => {
        "idOrder": idOrder,
        "idUser": idUser,
        "status": status,
        "username": username,
        "productsInCartList":
            List<dynamic>.from(productsInCartList.map((x) => x)),
        "direction": direction,
        "typeDelivery": typeDelivery,
        "contactNumber": contactNumber,
        "comments": comments,
        "paymentType": paymentType,
      };
}
