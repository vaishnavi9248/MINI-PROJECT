import 'dart:convert';

DepartmentModel departmentFromJson(String str) =>
    DepartmentModel.fromJson(json.decode(str));

String departmentToJson(DepartmentModel data) => json.encode(data.toJson());

class DepartmentModel {
  DepartmentModel({
    this.id = "",
    required this.name,
  });

  final String id;
  final String name;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      DepartmentModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
