import 'package:flutter/material.dart';



class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Admin Dashboard",
              style: TextStyle(
                color: Colors.black,
                fontSize: 45,
              ),
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

                    //Get.to(() =>);
                  },
                  child: const Text("Nominations"),
                ),
                const SizedBox(width: 18.0),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Students add/edit"),
                ),

                const SizedBox(width: 18.0),

              ],
            ),
            //search in google how to centre row widgets in flutter
            //apply inside row
            //go..
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("publish result"),
                ),
                const SizedBox(width: 18.0),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Start Election"),
                ),
                //multi child widget
                //inside children


                //single child widget
                //inside child


          //     voice ayakk
              ],

            )
          ],
        ),
      ),
    );
  }
}
