import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/controller/student/student_controller.dart';
import 'package:online_voting_system/utility/size.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  StudentController studentController = Get.put(StudentController());

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Student Login",
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
              ),
            ),
            const SizedBox(height: 14.0),
            SizedBox(
              width: responsiveWidth(MediaQuery.of(context).size.width),
              child: Form(
                key: studentController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: studentController.admissionNo,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Admission No',
                        labelText: "Admission No",
                      ),
                      validator: (String? value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "Admission No is mandatory";
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14.0),
                    TextFormField(
                      controller: studentController.dateOfBirth,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Date of Birth',
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            child: Icon(
                                hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey)),
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: hidePassword,
                      validator: (String? value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "DOB is mandatory";
                          }
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 26.0),
            Obx(
              () => ElevatedButton(
                onPressed: studentController.loading.value
                    ? null
                    : () => studentController.login(context),
                child: Text(
                  studentController.loading.value ? "Please wait..." : "Submit",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
