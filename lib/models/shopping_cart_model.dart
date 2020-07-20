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
    this.price,
    this.productComment,
    this.mealFor,
  });

  String idCar;
  String idProduct;
  int quantityProducts;
  double price;
  String productComment;
  String mealFor;

  factory ShoppingCartModel.fromJson(Map<String, dynamic> json) =>
      ShoppingCartModel(
        idCar: json["idCar"],
        idProduct: json["idProduct"],
        quantityProducts: json["quantityProducts"],
        price: json["price"],
        productComment: json["productComment"],
        mealFor: json["mealFor"],
      );

  Map<String, dynamic> toJson() => {
        "idCar": idCar,
        "idProduct": idProduct,
        "quantityProducts": quantityProducts,
        "price": price,
        "productComment": productComment,
        "mealFor": mealFor,
      };
}
