import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/data/model/course_model.dart';
import 'package:online_voting_system/data/model/semester_model.dart';
import 'package:online_voting_system/data/repository/common_repository.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/view/admin/student/student_detail.dart';
import 'package:online_voting_system/view/admin/student/student_list.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';
import 'package:online_voting_system/widget/student_tile.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final CommonRepository _repository = CommonRepository();
  final FirebaseService _firebaseService = FirebaseService();

  CourseModel? selectedCourse;
  bool courseLoading = false;
  List<CourseModel> courses = [];

  SemesterModel? selectedSemester;
  bool semesterLoading = false;
  List<SemesterModel> semesters = [];

  @override
  void initState() {
    getCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonHeading(title: "Student List"),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Course: "),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<CourseModel>(
                        isDense: true,
                        hint: Text(courseLoading ? " Loading..." : "Course"),
                        value: selectedCourse,
                        items: courses.map((CourseModel value) {
                          return DropdownMenuItem<CourseModel>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (CourseModel? value) {
                          if (value != null) {
                            setState(() => selectedCourse = value);
                            getSemesters(value.id);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 22.0),
                  const Text("Semester: "),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<SemesterModel>(
                        isDense: true,
                        hint:
                            Text(semesterLoading ? " Loading..." : "Semester"),
                        value: selectedSemester,
                        items: semesters.map((SemesterModel value) {
                          return DropdownMenuItem<SemesterModel>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (SemesterModel? value) =>
                            setState(() => selectedSemester = value!),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8.0),
              if (MediaQuery.of(context).size.width > 550) ...[
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const StudentDetail());
                  },
                  child: const Text("Add New"),
                ),
              ]
            ],
          ),
          const SizedBox(height: 8.0),
          if (MediaQuery.of(context).size.width <= 550) ...[
            ElevatedButton(
              onPressed: () {
                Get.to(() => const StudentDetail());
              },
              child: const Text("Add New"),
            ),
            const SizedBox(height: 8.0),
          ],
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8.0),
                  const StudentTile(
                    id: "Ad.No",
                    name: "Name",
                    email: "Email",
                    dob: "DOB",
                    hideButton: true,
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: selectedCourse == null || selectedSemester == null
                        ? const Center(
                            child: Text("Please select course and semester"))
                        : StreamBuilder(
                            stream: _firebaseService.getStudentDocs(
                              semesterId: selectedSemester!.id,
                              courseId: selectedCourse!.id,
                            ),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                    child: Text('Something went wrong'));
                              }

                              if (snapshot.hasData) {
                                List<DocumentSnapshot> data =
                                    snapshot.data!.docs;

                                if (data.isEmpty) {
                                  return const Center(
                                      child: Text("No Students"));
                                }

                                if (data.isNotEmpty) {
                                  return StudentList(
                                    data: data,
                                    firebaseService: _firebaseService,
                                  );
                                }
                              }

                              return const Center(child: Text("Loading"));
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getCourses() async {
    setState(() {
      courseLoading = true;
      courses = [];
      selectedCourse = null;
    });

    courses = await _repository.getCourses();
    courseLoading = false;

    setState(() {});
  }

  Future<void> getSemesters(String id) async {
    setState(() {
      semesterLoading = true;
      semesters = [];
      selectedSemester = null;
    });

    semesters = await _repository.getSemestersById(id);
    semesterLoading = false;

    setState(() {});
  }
}
