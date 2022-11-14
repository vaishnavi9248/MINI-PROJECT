import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_voting_system/utility/size.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';
import 'package:online_voting_system/widget/custom_form_field.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({Key? key}) : super(key: key);

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController admissionNo = TextEditingController();
  TextEditingController ktuId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  DateTime? dob;
  String? selectedSex;

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
                          return "Mandatory ";
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
                          return "Mandatory ";
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
                          return "Mandatory ";
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
                          return "Mandatory ";
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
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101));
                          if (picked != null) {
                            setState(() => dob = picked);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
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
}
