import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/controller/admin/admin_login_controller.dart';
import 'package:online_voting_system/utility/size.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminLoginController adminLoginController = Get.put(AdminLoginController());

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Admin Login",
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
              ),
            ),
            const SizedBox(height: 14.0),
            SizedBox(
              width: responsiveWidth(MediaQuery.of(context).size.width),
              child: Form(
                key: adminLoginController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: adminLoginController.userName,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'User Name',
                        labelText: "User Name",
                      ),
                      validator: (String? value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "User name is mandatory";
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14.0),
                    TextFormField(
                      controller: adminLoginController.password,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'password',
                      ),
                      validator: (String? value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "Password is mandatory";
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
                onPressed: adminLoginController.loading.value
                    ? null
                    : () => adminLoginController.adminLogin(),
                child: Text(
                  adminLoginController.loading.value ? "Loading..." : "Submit",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
