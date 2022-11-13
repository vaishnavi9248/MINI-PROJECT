import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/data/model/semester_model.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/widget/semester_tile.dart';

class SemesterList extends StatelessWidget {
  const SemesterList({
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
        SemesterModel semesterData = SemesterModel.fromJson(
          data[index].data() as Map<String, dynamic>,
        );

        return SemesterTile(
          no: (index + 1).toString(),
          semester: semesterData.name,
          department: semesterData.departmentName,
          onDelete: () => deleteSemester(semesterData.id),
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

  Future<void> deleteSemester(String id) async {
    await firebaseService.deleteDoc(
      collectionName: CollectionName.semesters,
      id: id,
    );
  }
}
