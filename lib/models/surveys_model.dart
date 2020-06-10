import 'dart:convert';

SurveysModel surveysModelFromJson(String str) =>
    SurveysModel.fromJson(json.decode(str));

String surveysModelToJson(SurveysModel data) => json.encode(data.toJson());

class SurveysModel {
  SurveysModel({
    this.idSurvey,
    this.idUser,
    this.userEmail,
    this.userTelephone,
    this.date,
    this.question1,
    this.question2,
    this.question3,
    this.question4,
    this.question5,
  });

  int idSurvey;
  String idUser;
  String userEmail;
  int userTelephone;
  String date;
  List<String> question1;
  List<String> question2;
  List<String> question3;
  List<String> question4;
  List<String> question5;

  factory SurveysModel.fromJson(Map<String, dynamic> json) => SurveysModel(
        idSurvey: json["idSurvey"],
        idUser: json["idUser"],
        userEmail: json["userEmail "],
        userTelephone: json["userTelephone"],
        date: json["date"],
        question1: List<String>.from(json["question1"].map((x) => x)),
        question2: List<String>.from(json["question2"].map((x) => x)),
        question3: List<String>.from(json["question3"].map((x) => x)),
        question4: List<String>.from(json["question4"].map((x) => x)),
        question5: List<String>.from(json["question5"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "idSurvey": idSurvey,
        "idUser": idUser,
        "userEmail ": userEmail,
        "userTelephone": userTelephone,
        "date": date,
        "question1": List<dynamic>.from(question1.map((x) => x)),
        "question2": List<dynamic>.from(question2.map((x) => x)),
        "question3": List<dynamic>.from(question3.map((x) => x)),
        "question4": List<dynamic>.from(question4.map((x) => x)),
        "question5": List<dynamic>.from(question5.map((x) => x)),
      };
}
