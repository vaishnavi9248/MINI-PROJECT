import 'dart:convert';

StudentModel studentFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel({
    this.admissionNo = "",
    this.name = "",
    this.ktuId = "",
    this.email = "",
    this.sex = "",
    this.dob,
    this.courseId = "",
    this.courseName = "",
    this.semesterId = "",
    this.semesterName = "",
    this.isVoted = false,
  });

  String admissionNo;
  String ktuId;
  String name;
  String email;
  String sex;
  String courseId;
  String courseName;
  String semesterId;
  String semesterName;
  DateTime? dob;
  bool isVoted;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        admissionNo: json["id"] ?? "",
        name: json["name"] ?? "",
        ktuId: json["ktuId"] ?? "",
        email: json["email"] ?? "",
        sex: json["sex"] ?? "",
        courseId: json["courseId"] ?? "",
        courseName: json["courseName"] ?? "",
        semesterId: json["semesterId"] ?? "",
        semesterName: json["semesterName"] ?? "",
        dob: json["dob"] == null ? DateTime.now() : json["dob"].toDate(),
        isVoted: json["isVoted"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": admissionNo,
        "name": name,
        "ktuId": ktuId,
        "email": email,
        "sex": sex,
        "dob": dob,
        "courseId": courseId,
        "courseName": courseName,
        "semesterId": semesterId,
        "semesterName": semesterName,
        "isVoted": isVoted,
      };
}
