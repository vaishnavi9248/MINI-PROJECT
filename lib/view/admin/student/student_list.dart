import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/const/database_names.dart';
import 'package:online_voting_system/view/admin/student/student_detail.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  List list = [];

  fetchStudentList() async {
    list = [];
    await db.collection(DataBaseName.students).get().then((event) {
      for (var doc in event.docs) {
        list.add(doc.data());
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    fetchStudentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Student List",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const StudentDetail());
                  },
                  child: const Text("Add"),
                )
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                child: ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("index $index"),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
