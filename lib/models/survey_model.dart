// To parse this JSON data, do
//
//     final surveyModel = surveyModelFromJson(jsonString);

import 'dart:convert';

SurveyModel surveyModelFromJson(String str) => SurveyModel.fromJson(json.decode(str));

String surveyModelToJson(SurveyModel data) => json.encode(data.toJson());

class SurveyModel {
    SurveyModel({
        this.idQuestion,
        this.answer1,
        this.answer2,
        this.answer3,
        this.answer4,
        this.answer5,
        this.question,
        this.totalResponses,
    });

    String idQuestion;
    int answer1;
    int answer2;
    int answer3;
    int answer4;
    int answer5;
    String question;
    int totalResponses;

    factory SurveyModel.fromJson(Map<String, dynamic> json) => SurveyModel(
        idQuestion: json["idQuestion"],
        answer1: json["answer1"],
        answer2: json["answer2"],
        answer3: json["answer3"],
        answer4: json["answer4"],
        answer5: json["answer5"],
        question: json["question"],
        totalResponses: json["totalResponses"],
    );

    Map<String, dynamic> toJson() => {
        "idQuestion": idQuestion,
        "answer1": answer1,
        "answer2": answer2,
        "answer3": answer3,
        "answer4": answer4,
        "answer5": answer5,
        "question": question,
        "totalResponses": totalResponses,
    };
}
