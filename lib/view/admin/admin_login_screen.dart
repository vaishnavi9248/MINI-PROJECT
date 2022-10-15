import 'package:flutter/material.dart';
import 'package:online_voting_system/utility/custom_print.dart';
import 'package:online_voting_system/utility/size.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController userName = TextEditingController();
    TextEditingController password = TextEditingController();

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
              width: customWidth(MediaQuery.of(context).size.width),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: userName,
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
                      controller: password,
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
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  customPrint("Username ${userName.text}");
                  customPrint("password ${password.text}");

                  //

                  //firebase code

                  //
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
