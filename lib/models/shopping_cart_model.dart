import 'dart:convert';

ShoppingCartModel shoppingCartModelFromJson(String str) =>
    ShoppingCartModel.fromJson(json.decode(str));

String shoppingCartModelToJson(ShoppingCartModel data) =>
    json.encode(data.toJson());

class ShoppingCartModel {
  ShoppingCartModel({
    this.idCarrito,
    this.idProduct,
    this.quantityProducts,
    this.productComment,
  });

  String idCarrito;
  String idProduct;
  int quantityProducts;
  String productComment;

  factory ShoppingCartModel.fromJson(Map<String, dynamic> json) =>
      ShoppingCartModel(
        idCarrito: json["idCarrito"],
        idProduct: json["idProduct"],
        quantityProducts: json["quantityProducts"],
        productComment: json["productComment"],
      );

  Map<String, dynamic> toJson() => {
        "idCarrito": idCarrito,
        "idProduct": idProduct,
        "quantityProducts": quantityProducts,
        "productComment": productComment,
      };
}
