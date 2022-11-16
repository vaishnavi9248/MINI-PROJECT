import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/firebase_options.dart';
import 'package:online_voting_system/view/admin/admin/admin_dashboard.dart';
import 'package:online_voting_system/view/admin/admin/admin_login_screen.dart';
import 'package:online_voting_system/view/home.dart';
import 'package:online_voting_system/view/nomination/nomination_form.dart';
import 'package:online_voting_system/view/nomination/nomination_list.dart';
import 'package:online_voting_system/view/result/result_screen.dart';
import 'package:online_voting_system/view/student/student_dashboard.dart';
import 'package:online_voting_system/view/student/student_login.dart';
import 'package:online_voting_system/view/vote/voting_screen.dart';

Future<void> main() async {
  await initialize();

  runApp(const MyApp());
}

Future<void> initialize() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Home()),
        GetPage(name: '/StudentLogin', page: () => const StudentLogin()),
        GetPage(
          name: '/StudentDashboard',
          page: () => const StudentDashboard(),
        ),
        GetPage(
          name: '/NominationForm',
          page: () => const NominationForm(),
        ),
        GetPage(
          name: '/AdminDashboard',
          page: () => const AdminDashboard(),
        ),
        GetPage(
          name: '/AdminLoginScreen',
          page: () => const AdminLoginScreen(),
        ),
        GetPage(
          name: '/NominationList',
          page: () => const NominationList(),
        ),
        GetPage(
          name: '/VotingScreen',
          page: () => const VotingScreen(),
        ),
        GetPage(
          name: '/ResultScreen',
          page: () => const ResultScreen(),
        ),
      ],
    );
  }
}
