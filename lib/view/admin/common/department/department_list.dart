import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/data/model/department_model.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/widget/department_tile.dart';

class DepartmentList extends StatelessWidget {
  const DepartmentList(
      {Key? key, required this.data, required this.firebaseService})
      : super(key: key);

  final List<DocumentSnapshot> data;

  final FirebaseService firebaseService;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        DepartmentModel model = DepartmentModel.fromJson(
          data[index].data() as Map<String, dynamic>,
        );

        return DepartmentTile(
          no: (index + 1).toString(),
          department: model.name,
          onDelete: () => deleteDepartment(model.id),
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

  Future<void> deleteDepartment(String id) async {
    await firebaseService.deleteDoc(
      collectionName: CollectionName.courses,
      id: id,
    );
  }
}
