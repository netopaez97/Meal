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
    this.availability,
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
  bool availability;
  String image;
  double rating;
  int numberRatings;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        idProduct: json["idProduct"],
        name: json["name"],
        currentPrice: json["currentPrice"].toDouble(),
        category: json["category"],
        discount: json["discount"].toDouble(),
        description: json["description"],
        availability: json["availability"],
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
        "availability": availability,
        "image": image,
        "rating": rating,
        "numberRatings": numberRatings,
      };
}
