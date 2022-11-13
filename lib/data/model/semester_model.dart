import 'dart:convert';

SemesterModel semesterFromJson(String str) =>
    SemesterModel.fromJson(json.decode(str));

String semesterToJson(SemesterModel data) => json.encode(data.toJson());

class SemesterModel {
  SemesterModel({
    this.id = "",
    required this.name,
    required this.departmentId,
    required this.departmentName,
  });

  final String id;
  final String name;
  final String departmentId;
  final String departmentName;

  factory SemesterModel.fromJson(Map<String, dynamic> json) => SemesterModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        departmentId: json["departmentId"] ?? "",
        departmentName: json["departmentName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "departmentId": departmentId,
        "departmentName": departmentName,
      };
}
