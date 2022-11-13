import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/firebase_options.dart';

import 'view/admin/common/semester/semester_screen.dart';

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
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SemesterScreen(),
    );
  }
}
