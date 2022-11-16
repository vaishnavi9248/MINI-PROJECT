import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/controller/common_controller.dart';
import 'package:online_voting_system/view/admin/common/course/course_screen.dart';
import 'package:online_voting_system/view/admin/common/semester/semester_screen.dart';
import 'package:online_voting_system/view/admin/student/student_screen.dart';
import 'package:online_voting_system/view/nomination/nomination_list.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  static CommonController commonController = CommonController();

  @override
  Widget build(BuildContext context) {
    commonController.getMainInfo();
    return CommonScaffold(
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            const CommonHeading(
              title: "Admin Dashboard",
              fontSize: 36,
            ),
            const SizedBox(height: 38.0),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  spacing: 18.0,
                  runSpacing: 12.0,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => const CourseScreen());
                      },
                      child: const Text("Courses"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => const SemesterScreen());
                      },
                      child: const Text("Semesters"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => const StudentScreen());
                      },
                      child: const Text("Students"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => const NominationList());
                      },
                      child: const Text("Nominations"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        commonController.updateField({
                          "nominationStart": !commonController
                              .mainInfoModel.value.nominationStart,
                        });
                      },
                      child: Text(
                          "Nomination ${commonController.mainInfoModel.value.nominationStart ? "End" : "Start"}"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        commonController.updateField({
                          "resultPublished": !commonController
                              .mainInfoModel.value.resultPublished
                        });
                      },
                      child: Text(
                          "Publish Result ${commonController.mainInfoModel.value.resultPublished ? "Stop" : "Start"}"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        commonController.updateField({
                          "electionStart": !commonController
                              .mainInfoModel.value.electionStart
                        });
                      },
                      child: Text(
                          "Election ${commonController.mainInfoModel.value.electionStart ? "End" : "Start"}"),
                    ),
                  ],
                ),
              ),
            ),
            if (commonController.loading.value)
              const Text("Updating data...Please wait...."),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
