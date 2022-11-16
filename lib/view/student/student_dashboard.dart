import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_voting_system/controller/common_controller.dart';
import 'package:online_voting_system/controller/nomination_controller.dart';
import 'package:online_voting_system/controller/student/student_controller.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  static StudentController studentController = Get.put(StudentController());
  static NominationController nominationController =
      Get.put(NominationController());
  static CommonController commonController = Get.put(CommonController());

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Obx(
        () => studentController.loading.value ||
                nominationController.loading.value ||
                commonController.loading.value
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
                    value:
                        "DOB: ${DateFormat("dd-MM-yyy").format(studentController.studentModel.value.dob ?? DateTime.now())}",
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
                          "Nomination Status: ${nominationController.nominationData.value.status}"),
                  StudentDataTile(
                      value:
                          "Vote Status: ${studentController.studentModel.value.isVoted ? "Voted" : "Not voted"}"),
                  const SizedBox(height: 16.0),
                  if (commonController.mainInfoModel.value.nominationStart &&
                      nominationController.nominationData.value.status.isEmpty)
                    ElevatedButton(
                        onPressed: () {
                          Get.toNamed(
                            "/NominationForm",
                            parameters: {
                              "id": studentController
                                  .studentModel.value.admissionNo
                            },
                          );
                        },
                        child: const Text("Nomination")),
                  const SizedBox(height: 8.0),
                  if (commonController.mainInfoModel.value.electionStart &&
                      !studentController.studentModel.value.isVoted)
                    ElevatedButton(
                        onPressed: () {
                          // Get.to(() => const VotingScreen());

                          Get.toNamed(
                            "/VotingScreen",
                            parameters: {
                              "studentId": studentController
                                  .studentModel.value.admissionNo,
                              "courseId": studentController
                                  .studentModel.value.courseName,
                              "semesterId": studentController
                                  .studentModel.value.semesterName,
                            },
                          );
                        },
                        child: const Text("Vote")),
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
