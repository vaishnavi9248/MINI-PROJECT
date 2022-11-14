import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/data/model/course_model.dart';
import 'package:online_voting_system/data/model/semester_model.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/utility/size.dart';
import 'package:online_voting_system/utility/snackbar.dart';
import 'package:online_voting_system/view/admin/common/semester/semester_list.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';
import 'package:online_voting_system/widget/custom_form_field.dart';
import 'package:online_voting_system/widget/semester_tile.dart';

class SemesterScreen extends StatefulWidget {
  const SemesterScreen({Key? key}) : super(key: key);

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  TextEditingController controller = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  CourseModel? selectedValue;
  bool courseLoading = false;
  List<CourseModel> courses = [];

  @override
  void initState() {
    getCourseList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width =
        responsiveWidthByPercentage(context: context, percentage: 0.5);

    return CommonScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonHeading(title: "Semester List"),
          SizedBox(
            width: width,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<CourseModel>(
                        isExpanded: true,
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            courseLoading ? " Loading..." : "Course",
                          ),
                        ),
                        value: selectedValue,
                        items: courses.map((CourseModel value) {
                          return DropdownMenuItem<CourseModel>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value.name),
                            ),
                          );
                        }).toList(),
                        onChanged: (CourseModel? value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: CustomFormField(
                      controller: controller,
                      label: 'Semester',
                      isDense: false,
                      onSubmit: (String? value) {
                        if (value != null) addSemester();
                        return null;
                      }),
                ),
                SizedBox(width: width * 0.05),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty && selectedValue != null) {
                      addSemester();
                    } else {
                      showSnackBar(
                        context: context,
                        text: "Please select course and add semester",
                      );
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
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
                  const SemesterTile(
                    no: "No.",
                    course: "Course",
                    semester: "Semester",
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: StreamBuilder(
                      stream: _firebaseService.getCollectionStreamOrderBy(
                        collectionName: CollectionName.semesters,
                        orderBy: "departmentName",
                        orderByNew: "name",
                      ),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }

                        if (snapshot.hasData) {
                          List<DocumentSnapshot> data = snapshot.data!.docs;

                          if (data.isEmpty) {
                            return const Center(child: Text("No Data"));
                          }

                          if (data.isNotEmpty) {
                            return SemesterList(
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

  Future<void> addSemester() async {
    final text = controller.text.toUpperCase();

    controller.text = "";
    await _firebaseService.addDoc(
      collectionName: CollectionName.semesters,
      data: SemesterModel(
        departmentId: selectedValue!.id,
        departmentName: selectedValue!.name,
        name: text,
      ).toJson(),
    );
  }

  Future<void> getCourseList() async {
    setState(() => courseLoading = true);
    List<DocumentSnapshot> result = await _firebaseService.getData(
      collectionName: CollectionName.courses,
      orderBy: "name",
    );

    for (var element in result) {
      CourseModel courseModel =
          CourseModel.fromJson(element.data() as Map<String, dynamic>);
      courses.add(courseModel);
    }
    courseLoading = false;

    setState(() {});
  }
}
