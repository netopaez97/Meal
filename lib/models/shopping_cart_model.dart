import 'dart:convert';

ShoppingCartModel shoppingCartModelFromJson(String str) =>
    ShoppingCartModel.fromJson(json.decode(str));

String shoppingCartModelToJson(ShoppingCartModel data) =>
    json.encode(data.toJson());

class ShoppingCartModel {
  ShoppingCartModel({
    this.idCar,
    this.idProduct,
    this.quantityProducts,
    this.productComment,
  });

  int idCar;
  String idProduct;
  int quantityProducts;
  String productComment;

  factory ShoppingCartModel.fromJson(Map<String, dynamic> json) =>
      ShoppingCartModel(
        idCar: json["idCar"],
        idProduct: json["idProduct"],
        quantityProducts: json["quantityProducts"],
        productComment: json["productComment"],
      );

  Map<String, dynamic> toJson() => {
        "idCar": idCar,
        "idProduct": idProduct,
        "quantityProducts": quantityProducts,
        "productComment": productComment,
      };
}
