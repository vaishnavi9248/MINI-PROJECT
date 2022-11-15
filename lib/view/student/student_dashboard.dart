import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/controller/student/student_controller.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  static StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Obx(
        () => studentController.loading.value
            ? const Center(child: Text("Loading..."))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonHeading(title: "Your Details"),
                  StudentDataTile(
                    value: "Name: ${studentController.studentModel.value.name}",
                  ),
                  StudentDataTile(
                    value:
                        "Ad.No: ${studentController.studentModel.value.admissionNo}",
                  ),
                  StudentDataTile(
                    value:
                        "KTU id: ${studentController.studentModel.value.ktuId}",
                  ),
                  StudentDataTile(
                    value:
                        "Email: ${studentController.studentModel.value.email}",
                  ),
                  StudentDataTile(
                    value: "DOB: ${studentController.studentModel.value.dob}",
                  ),
                  StudentDataTile(
                    value:
                        "Class: ${studentController.studentModel.value.courseName} ${studentController.studentModel.value.semesterName}",
                  ),
                  StudentDataTile(
                    value: "Sex: ${studentController.studentModel.value.sex}",
                  ),
                  StudentDataTile(
                    value:
                        "Nomination Status: ${studentController.studentModel.value.nominationId.isEmpty ? "Not applied" : ""}",
                  ),
                  const StudentDataTile(value: "Vote Status: Not voted"),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Nomination")),
                  const SizedBox(height: 8.0),
                  ElevatedButton(onPressed: () {}, child: const Text("Vote")),
                ],
              ),
      ),
    );
  }
}

class StudentDataTile extends StatelessWidget {
  const StudentDataTile({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
      ),
    );
  }
}
