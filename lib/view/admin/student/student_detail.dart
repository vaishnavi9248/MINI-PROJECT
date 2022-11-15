import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/data/model/course_model.dart';
import 'package:online_voting_system/data/model/semester_model.dart';
import 'package:online_voting_system/data/model/student_model.dart';
import 'package:online_voting_system/data/repository/common_repository.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/utility/size.dart';
import 'package:online_voting_system/utility/snackbar.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';
import 'package:online_voting_system/widget/custom_form_field.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({Key? key}) : super(key: key);

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  final FirebaseService _firebaseService = FirebaseService();
  final CommonRepository _repository = CommonRepository();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController admissionNo = TextEditingController();
  TextEditingController ktuId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  DateTime? dob;
  String? selectedSex;

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
      child: Center(
        child: SizedBox(
          width: responsiveWidth(MediaQuery.of(context).size.width),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CommonHeading(title: "Student Form"),
                  CustomFormField(
                    controller: admissionNo,
                    label: "Admission No",
                    validator: (String? value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Fill the field";
                        }
                      }

                      return null;
                    },
                  ),
                  CustomFormField(
                    controller: ktuId,
                    label: "KTU Id",
                    validator: (String? value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Fill the field";
                        }
                      }

                      return null;
                    },
                  ),
                  CustomFormField(
                    controller: name,
                    label: "Student Name",
                    validator: (String? value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Fill the field";
                        }
                        // if (value.contains(RegExp(r'[0-9]'))) {
                        //   return "Must be number";
                        // }
                      }

                      return null;
                    },
                  ),
                  CustomFormField(
                    controller: email,
                    label: "Email",
                    validator: (String? value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Fill the field";
                        }
                        // if (value.contains(RegExp(r'[0-9]'))) {
                        //   return "Must be number";
                        // }
                      }

                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            hint:
                                Text(courseLoading ? " Loading..." : "Course"),
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
                            hint: Text(
                                semesterLoading ? " Loading..." : "Semester"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("SEX: "),
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            hint: const Text('Select'),
                            value: selectedSex,
                            items: ["Male", "Female", "Others"]
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) =>
                                setState(() => selectedSex = value!),
                          ),
                        ),
                      ),
                      const SizedBox(width: 22.0),
                      const Text("DOB: "),
                      ElevatedButton(
                        child: Text(
                          dob == null
                              ? "Select"
                              : DateFormat("dd-MM-yyyy").format(dob!),
                        ),
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2004),
                            firstDate: DateTime(1970),
                            lastDate: DateTime(2004, 12, 31),
                          );
                          if (picked != null) {
                            setState(() => dob = picked);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      submit();
                    },
                    child: const Text("Submit"),
                  )
                ]
                    .map(
                      (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: e),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getCourses() async {
    setState(() => courseLoading = true);

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

  void submit() {
    if (formKey.currentState!.validate()) {
      String selectionValidation = errorMessage();

      if (selectionValidation.isNotEmpty) {
        showSnackBar(context: context, text: selectionValidation);
      } else {
        String id = admissionNo.text.trim();

        StudentModel data = StudentModel(
          admissionNo: id,
          name: name.text.trim().toUpperCase(),
          ktuId: ktuId.text.trim(),
          email: email.text.trim(),
          sex: selectedSex!,
          dob: dob!,
          courseId: selectedCourse!.id,
          courseName: selectedCourse!.name,
          semesterId: selectedSemester!.id,
          semesterName: selectedSemester!.name,
        );

        _firebaseService.addDocById(
          collectionName: CollectionName.students,
          id: id,
          data: data.toJson(),
        );
        Get.back();

        showSnackBar(context: context, text: "Student added");
      }
    }
  }

  String errorMessage() {
    List<String> errorStrings = [];

    if (selectedCourse == null) {
      errorStrings.add("Course");
    }

    if (selectedSemester == null) {
      errorStrings.add("Semester");
    }

    if (selectedSex == null) {
      errorStrings.add("Sex");
    }

    if (dob == null) {
      errorStrings.add("Date of birth");
    }

    if (errorStrings.isEmpty) {
      return "";
    } else {
      String message = "Please fill ";
      return message + errorStrings.join(", ");
    }
  }
}
