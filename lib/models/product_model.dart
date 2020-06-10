import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.idProduct,
    this.name,
    this.durrentPrice,
    this.dategory,
    this.disccount,
    this.description,
    this.amount,
    this.image,
    this.qualification,
    this.numberRatings,
  });

  String idProduct;
  String name;
  int durrentPrice;
  String dategory;
  double disccount;
  String description;
  int amount;
  String image;
  int qualification;
  int numberRatings;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        idProduct: json["idProduct"],
        name: json["name"],
        durrentPrice: json["durrentPrice"],
        dategory: json["dategory"],
        disccount: json["disccount"].toDouble(),
        description: json["description"],
        amount: json["amount"],
        image: json["image"],
        qualification: json["qualification"],
        numberRatings: json["numberRatings"],
      );

  Map<String, dynamic> toJson() => {
        "idProduct": idProduct,
        "name": name,
        "durrentPrice": durrentPrice,
        "dategory": dategory,
        "disccount": disccount,
        "description": description,
        "amount": amount,
        "image": image,
        "qualification": qualification,
        "numberRatings": numberRatings,
      };
}
