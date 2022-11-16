import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_voting_system/controller/nomination_controller.dart';
import 'package:online_voting_system/controller/student/student_controller.dart';
import 'package:online_voting_system/utility/size.dart';
import 'package:online_voting_system/view/student/student_dashboard.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';
import 'package:online_voting_system/widget/custom_form_field.dart';

class NominationForm extends StatefulWidget {
  const NominationForm({Key? key}) : super(key: key);

  @override
  State<NominationForm> createState() => _NominationFormState();
}

class _NominationFormState extends State<NominationForm> {
  static StudentController studentController = Get.put(StudentController());
  static NominationController nominationController =
      Get.put(NominationController());

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Form(
        key: nominationController.formKey,
        child: Obx(
          () => SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonHeading(title: "Nomination Form"),
                  if (!nominationController.loading.value &&
                      !studentController.loading.value) ...[
                    StudentBasicDetailsWidget(
                      name: studentController.studentModel.value.name,
                      adNo: studentController.studentModel.value.admissionNo,
                      ktuId: studentController.studentModel.value.ktuId,
                      email: studentController.studentModel.value.email,
                      dob: DateFormat("dd-MM-yyy").format(
                          studentController.studentModel.value.dob ??
                              DateTime.now()),
                      course:
                          "${studentController.studentModel.value.courseName} ${studentController.studentModel.value.semesterName}",
                      sex: studentController.studentModel.value.sex,
                    ),
                    PrimaryProposer(
                      admissionNo: nominationController.p1AdmissionNo,
                      ktuId: nominationController.p1KtuId,
                      name: nominationController.p1Name,
                    ),
                    const SizedBox(height: 8.0),
                    SecondaryProposer(
                      admissionNo: nominationController.p2AdmissionNo,
                      ktuId: nominationController.p2KtuId,
                      name: nominationController.p2Name,
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        nominationController.applyNomination(
                          id: studentController.studentModel.value.admissionNo,
                          name: studentController.studentModel.value.name,
                          semester:
                              studentController.studentModel.value.semesterName,
                          course:
                              studentController.studentModel.value.courseName,
                        );
                      },
                      child: Text(
                        nominationController.btnLoading.value
                            ? "Loading..."
                            : "Submit",
                      ),
                    )
                  ] else
                    const Text("Loading..."),
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
}

class PrimaryProposer extends StatelessWidget {
  const PrimaryProposer({
    Key? key,
    required this.admissionNo,
    required this.ktuId,
    required this.name,
  }) : super(key: key);

  final TextEditingController admissionNo;
  final TextEditingController ktuId;
  final TextEditingController name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: responsiveWidth(MediaQuery.of(context).size.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonHeading(
            title: "Primary Proposer Form",
            haveUnderLine: false,
          ),
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
        ],
      ),
    );
  }
}

class SecondaryProposer extends StatelessWidget {
  const SecondaryProposer({
    Key? key,
    required this.admissionNo,
    required this.ktuId,
    required this.name,
  }) : super(key: key);

  final TextEditingController admissionNo;
  final TextEditingController ktuId;
  final TextEditingController name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: responsiveWidth(MediaQuery.of(context).size.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonHeading(
            title: "Secondary Proposer Form",
            haveUnderLine: false,
          ),
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
        ],
      ),
    );
  }
}

class StudentBasicDetailsWidget extends StatelessWidget {
  const StudentBasicDetailsWidget(
      {Key? key,
      required this.name,
      required this.adNo,
      required this.ktuId,
      required this.email,
      required this.dob,
      required this.course,
      required this.sex})
      : super(key: key);

  final String name, adNo, ktuId, email, dob, course, sex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StudentDataTile(value: "Name: $name"),
        StudentDataTile(value: "Ad.No: $adNo"),
        StudentDataTile(value: "KTU id: $ktuId"),
        StudentDataTile(value: "Email: $email"),
        StudentDataTile(value: "DOB: $dob"),
        StudentDataTile(value: "Class: $course"),
        StudentDataTile(value: "Sex: $sex"),
      ],
    );
  }
}
