import 'package:flutter/material.dart';
import 'package:online_voting_system/utility/size.dart';
import 'package:online_voting_system/widget/custom_form_field.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({Key? key}) : super(key: key);

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController admissionNo = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: customWidth(MediaQuery.of(context).size.width),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Student Form",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomFormField(
                    admissionNo: admissionNo,
                    label: "Admission No",
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
                    admissionNo: name,
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
                    admissionNo: email,
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
