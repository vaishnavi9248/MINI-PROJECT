import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/view/admin/student/student_detail.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/student_tile.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  List list = [];

  Future<void> fetchStudentList() async {
    list = [];
    await db.collection(CollectionName.students).get().then((event) {
      for (var doc in event.docs) {
        Map<String, dynamic> data = {"id": doc.id};
        data.addAll(doc.data());

        list.add(data);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CommonHeading(title: "Student List"),
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
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StudentTile(
                        id: "A.No",
                        name: "Name",
                        email: "Email",
                        dob: "DOB",
                        hideButton: true,
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 4.0),
                    ListView.separated(
                      itemCount: list.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (BuildContext context, int index) {
                        return StudentTile(
                          id: list[index]['id'],
                          name: list[index]['name'],
                          email: list[index]['email'],
                          dob: list[index]['dob'],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Divider(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
