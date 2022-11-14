import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/data/model/course_model.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/utility/size.dart';
import 'package:online_voting_system/view/admin/common/course/course_list.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';
import 'package:online_voting_system/widget/course_tile.dart';
import 'package:online_voting_system/widget/custom_form_field.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key}) : super(key: key);

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
          const CommonHeading(title: "Course Section List"),
          SizedBox(
            width: width,
            child: Row(
              children: [
                Expanded(
                  child: CustomFormField(
                      controller: controller,
                      label: 'Course',
                      onSubmit: (String? value) {
                        if (value != null) addCourse();
                        return null;
                      }),
                ),
                SizedBox(width: width * 0.05),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      addCourse();
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
                  const CourseTile(
                    no: "No.",
                    course: "Course",
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: StreamBuilder(
                      stream: _firebaseService.getCollectionStream(
                        collectionName: CollectionName.courses,
                        orderBy: "name",
                      ),
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
                            return CourseList(
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

  Future<void> addCourse() async {
    final text = controller.text;

    controller.text = "";
    await _firebaseService.addDoc(
      collectionName: CollectionName.courses,
      data: CourseModel(name: text.toUpperCase()).toJson(),
    );
  }
}
