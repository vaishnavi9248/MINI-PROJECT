import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_system/data/model/course_model.dart';
import 'package:online_voting_system/data/model/nomination_model.dart';
import 'package:online_voting_system/data/model/semester_model.dart';
import 'package:online_voting_system/data/repository/common_repository.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
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
                    hint: Text(semesterLoading ? " Loading..." : "Semester"),
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
          const SizedBox(height: 8.0),
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
                  Expanded(
                    child: selectedCourse == null || selectedSemester == null
                        ? const Center(
                            child: Text("Please select course and semester"))
                        : StreamBuilder(
                            stream: _firebaseService.getResultList(
                              semesterId: selectedSemester!.name,
                              courseId: selectedCourse!.name,
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
                                      child: Text("No Candidates"));
                                }

                                if (data.isNotEmpty) {
                                  return ListView.builder(
                                    itemCount: data.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      NominationModel nominationData =
                                          NominationModel.fromJson(data[index]
                                              .data() as Map<String, dynamic>);

                                      return VoteCard(
                                        name: nominationData.candidateName,
                                        adNo: nominationData.candidateId,
                                        count: nominationData.count.toString(),
                                      );
                                    },
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

class VoteCard extends StatelessWidget {
  const VoteCard({
    Key? key,
    required this.name,
    required this.adNo,
    required this.count,
  }) : super(key: key);

  final String name;
  final String adNo;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: $name"),
                  Text("Ad.No: $adNo"),
                ],
              ),
            ),
            Container(
              height: 45,
              width: 70,
              alignment: Alignment.center,
              child: Text(
                count,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
