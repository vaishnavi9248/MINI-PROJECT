import 'dart:convert';

MainInfoModel mainInfoModelFromJson(String str) =>
    MainInfoModel.fromJson(json.decode(str));

String mainInfoModelToJson(MainInfoModel data) => json.encode(data.toJson());

class MainInfoModel {
  MainInfoModel({
    this.electionStart = false,
    this.nominationStart = false,
    this.nominationWithdraw = false,
    this.resultPublished = false,
  });

  bool electionStart;
  bool nominationStart;
  bool nominationWithdraw;
  bool resultPublished;

  factory MainInfoModel.fromJson(Map<String, dynamic> json) => MainInfoModel(
        electionStart: json["electionStart"] ?? false,
        nominationStart: json["nominationStart"] ?? false,
        nominationWithdraw: json["nominationWithdraw"] ?? false,
        resultPublished: json["resultPublished"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "electionStart": electionStart,
        "nominationStart": nominationStart,
        "nominationWithdraw": nominationWithdraw,
        "resultPublished": resultPublished,
      };
}
