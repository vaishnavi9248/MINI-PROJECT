import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/controller/admin/admin_login_controller.dart';
import 'package:online_voting_system/utility/size.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  AdminLoginController adminLoginController = Get.put(AdminLoginController());

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CommonHeading(title: "Admin Login", fontSize: 36),
            const SizedBox(height: 32.0),
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
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: adminLoginController.password,
                      keyboardType: TextInputType.text,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'password',
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
            const SizedBox(height: 32.0),
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
