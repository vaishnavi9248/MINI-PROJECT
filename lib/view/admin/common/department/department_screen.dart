import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/data/model/department_model.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/utility/size.dart';
import 'package:online_voting_system/view/admin/common/department/department_list.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';
import 'package:online_voting_system/widget/custom_form_field.dart';
import 'package:online_voting_system/widget/department_tile.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({Key? key}) : super(key: key);

  static TextEditingController controller = TextEditingController();

  static final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    double width =
        responsiveWidthByPercentage(context: context, percentage: 0.5);

    return CommonScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonHeading(title: "Department Section List"),
          SizedBox(
            width: width,
            child: Row(
              children: [
                Expanded(
                  child: CustomFormField(
                      controller: controller,
                      label: 'Department',
                      onSubmit: (String? value) {
                        if (value != null) addDepartment();
                        return null;
                      }),
                ),
                SizedBox(width: width * 0.05),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      addDepartment();
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
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
                  const SizedBox(height: 8.0),
                  const DepartmentTile(
                    no: "No.",
                    department: "Department",
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: StreamBuilder(
                      stream: _firebaseService.getData(
                          collectionName: CollectionName.courses,
                          orderBy: "name"),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }

                        if (snapshot.hasData) {
                          List<DocumentSnapshot> data = snapshot.data!.docs;

                          if (data.isEmpty) {
                            return const Center(child: Text("No Data"));
                          }

                          if (data.isNotEmpty) {
                            return DepartmentList(
                              data: data,
                              firebaseService: _firebaseService,
                            );
                          }
                        }

                        return const Center(child: Text("Loading"));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addDepartment() async {
    final text = controller.text;

    controller.text = "";
    await _firebaseService.addDoc(
      collectionName: CollectionName.courses,
      data: DepartmentModel(name: text.toUpperCase()).toJson(),
    );
  }
}
