import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.idProduct,
    this.name,
    this.currentPrice,
    this.category,
    this.discount,
    this.description,
    this.amount,
    this.image,
    this.rating,
    this.numberRatings,
  });

  String idProduct;
  String name;
  double currentPrice;
  String category;
  double discount;
  String description;
  int amount;
  String image;
  double rating;
  int numberRatings;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        idProduct: json["idProduct"],
        name: json["name"],
        currentPrice: json["currentPrice"],
        category: json["category"],
        discount: json["discount"].toDouble(),
        description: json["description"],
        amount: json["amount"],
        image: json["image"],
        rating: json["rating"],
        numberRatings: json["numberRatings"],
      );

  Map<String, dynamic> toJson() => {
        "idProduct": idProduct,
        "name": name,
        "currentPrice": currentPrice,
        "category": category,
        "discount": discount,
        "description": description,
        "amount": amount,
        "image": image,
        "rating": rating,
        "numberRatings": numberRatings,
      };
}
