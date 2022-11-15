import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/data/model/student_model.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/widget/student_tile.dart';

class StudentList extends StatelessWidget {
  const StudentList({
    Key? key,
    required this.data,
    required this.firebaseService,
  }) : super(key: key);

  final List<DocumentSnapshot> data;
  final FirebaseService firebaseService;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        StudentModel studentData =
            StudentModel.fromJson(data[index].data() as Map<String, dynamic>);

        return StudentTile(
          id: studentData.admissionNo,
          name: studentData.name,
          email: studentData.email,
          dob: DateFormat("dd-MM-yyyy").format(studentData.dob!),
          onView: () {},
          onEdit: () {},
          onDelete: () async {
            await firebaseService.deleteDoc(
              collectionName: CollectionName.students,
              id: studentData.admissionNo,
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: Divider(),
        );
      },
    );
  }
}
