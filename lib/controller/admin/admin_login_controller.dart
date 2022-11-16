import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/utility/snackbar.dart';
import 'package:online_voting_system/view/admin/admin/admin_dashboard.dart';

class AdminLoginController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool loading = false.obs;

  Future<void> adminLogin() async {
    if (formKey.currentState!.validate()) {
      loading.value = true;

      Map<String, dynamic>? data = await _firebaseService.getAdminInfo();

      if (data != null) {
        String name = data['userName'];
        String pass = data['password'];

        if (name == userName.text) {
          if (pass == password.text) {
            Get.off(() => const AdminDashboard());
            showSnackBar(context: Get.context!, text: "Successfully logged in");
          } else {
            showSnackBar(context: Get.context!, text: "Invalid password");
          }
        } else {
          showSnackBar(context: Get.context!, text: "Invalid user name");
        }

        loading.value = false;
      }
    }
  }
}
