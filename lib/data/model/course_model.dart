import 'dart:convert';

CourseModel departmentFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String departmentToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  CourseModel({
    this.id = "",
    required this.name,
  });

  final String id;
  final String name;

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
