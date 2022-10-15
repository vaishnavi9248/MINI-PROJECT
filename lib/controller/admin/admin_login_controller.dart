import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/utility/custom_print.dart';

class AdminLoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  void adminLogin() {
    if (formKey.currentState!.validate()) {
      customPrint("Username ${userName.text}");
      customPrint("password ${password.text}");

      //

      //firebase code

      //
    }
  }
}
