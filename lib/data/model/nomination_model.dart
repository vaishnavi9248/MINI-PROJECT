import 'dart:convert';

NominationModel nominationFromJson(String str) =>
    NominationModel.fromJson(json.decode(str));

String nominationToJson(NominationModel data) => json.encode(data.toJson());

class NominationModel {
  NominationModel({
    this.candidateId = "",
    this.candidateName = "",
    this.candidateCourse = "",
    this.candidateSemester = "",
    this.proposer1AdNo = "",
    this.proposer1KTUId = "",
    this.proposer1Name = "",
    this.proposer2AdNo = "",
    this.proposer2KTUId = "",
    this.proposer2Name = "",
    this.status = "",
    this.count = 0,
  });

  String candidateId;
  String candidateName;
  String candidateCourse;
  String candidateSemester;
  String proposer1AdNo;
  String proposer1KTUId;
  String proposer1Name;
  String proposer2AdNo;
  String proposer2KTUId;
  String proposer2Name;
  String status;
  int count;

  factory NominationModel.fromJson(Map<String, dynamic> json) =>
      NominationModel(
        candidateId: json["candidateId"] ?? "",
        candidateName: json["candidateName"] ?? "",
        candidateCourse: json["candidateCourse"] ?? "",
        candidateSemester: json["candidateSemester"] ?? "",
        proposer1AdNo: json["proposer1AdNo"] ?? "",
        proposer1KTUId: json["proposer1KTUId"] ?? "",
        proposer1Name: json["proposer1Name"] ?? "",
        proposer2AdNo: json["proposer2AdNo"] ?? "",
        proposer2KTUId: json["proposer2KTUId"] ?? "",
        proposer2Name: json["proposer2Name"] ?? "",
        status: json["status"] ?? "",
        count: json["count"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "candidateId": candidateId,
        "candidateName": candidateName,
        "candidateCourse": candidateCourse,
        "candidateSemester": candidateSemester,
        "proposer1AdNo": proposer1AdNo,
        "proposer1KTUId": proposer1KTUId,
        "proposer1Name": proposer1Name,
        "proposer2AdNo": proposer2AdNo,
        "proposer2KTUId": proposer2KTUId,
        "proposer2Name": proposer2Name,
        "status": status,
        "count": count,
      };
}
