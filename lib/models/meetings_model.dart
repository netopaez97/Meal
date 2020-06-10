import 'dart:convert';

MeetingsModel meetingsModelFromJson(String str) =>
    MeetingsModel.fromJson(json.decode(str));

String meetingsModelToJson(MeetingsModel data) => json.encode(data.toJson());

class MeetingsModel {
  MeetingsModel({
    this.idMeeting,
    this.guestListTelephone,
    this.guestListMail,
    this.timeMeeting,
  });

  String idMeeting;
  List<int> guestListTelephone;
  List<String> guestListMail;
  String timeMeeting;

  factory MeetingsModel.fromJson(Map<String, dynamic> json) => MeetingsModel(
        idMeeting: json["idMeeting"],
        guestListTelephone:
            List<int>.from(json["guestListTelephone"].map((x) => x)),
        guestListMail: List<String>.from(json["guestListMail"].map((x) => x)),
        timeMeeting: json["timeMeeting"],
      );

  Map<String, dynamic> toJson() => {
        "idMeeting": idMeeting,
        "guestListTelephone":
            List<dynamic>.from(guestListTelephone.map((x) => x)),
        "guestListMail": List<dynamic>.from(guestListMail.map((x) => x)),
        "timeMeeting": timeMeeting,
      };
}
