import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) =>
    RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) =>
    json.encode(data.toJson());

class RestaurantModel {
  RestaurantModel({
    this.idRestaurant,
    this.category,
    this.schedule,
    this.qualification,
  });

  String idRestaurant;
  String category;
  String schedule;
  int qualification;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        idRestaurant: json["idRestaurant"],
        category: json["category"],
        schedule: json["schedule"],
        qualification: json["qualification"],
      );

  Map<String, dynamic> toJson() => {
        "idRestaurant": idRestaurant,
        "category": category,
        "schedule": schedule,
        "qualification": qualification,
      };
}
