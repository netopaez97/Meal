import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({this.idUser, this.phone, this.ready, this.tokenFCM});

  String idUser;
  String phone;
  bool ready;
  String tokenFCM;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["idUser"],
        phone: json["phone"],
        ready: json["ready"],
        tokenFCM: json["tokenFCM"],
      );

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "phone": phone,
        "ready": ready,
        "tokenFCM": tokenFCM,
      };
}
