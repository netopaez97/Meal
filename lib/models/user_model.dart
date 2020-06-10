import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.idUser,
    this.name,
    this.lastName,
    this.gender,
    this.contactNumber,
    this.email,
  });

  String idUser;
  String name;
  String lastName;
  String gender;
  int contactNumber;
  String email;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["idUser"],
        name: json["name"],
        lastName: json["lastName"],
        gender: json["gender"],
        contactNumber: json["contactNumber"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "name": name,
        "lastName": lastName,
        "gender": gender,
        "contactNumber": contactNumber,
        "email": email,
      };
}
