import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/view/admin/admin/admin_login_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/college_logo.png"),
            const SizedBox(height: 18.0),
            const Text(
              "Online Voting System",
              style: TextStyle(
                color: Colors.black,
                fontSize: 45,
              ),
            ),
            const SizedBox(height: 14.0),
            const Text(
              "Welcome to the MES voting....",
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const AdminLoginScreen()),
                    // );

                    Get.to(() => const AdminLoginScreen());
                  },
                  child: const Text("Admin Login"),
                ),
                const SizedBox(width: 18.0),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Student Login"),
                ),
                const SizedBox(width: 18.0),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Nomination"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
