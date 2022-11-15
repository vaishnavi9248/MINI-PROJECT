import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/data/model/course_model.dart';
import 'package:online_voting_system/data/model/semester_model.dart';
import 'package:online_voting_system/services/firebase_service.dart';

class CommonRepository {
  final FirebaseService _firebaseService = FirebaseService();

  Future<List<CourseModel>> getCourses() async {
    List<DocumentSnapshot> result = await _firebaseService.getData(
      collectionName: CollectionName.courses,
      orderBy: "name",
    );

    List<CourseModel> courses = [];

    for (var element in result) {
      CourseModel courseModel =
          CourseModel.fromJson(element.data() as Map<String, dynamic>);
      courses.add(courseModel);
    }

    return courses;
  }

  Future<List<SemesterModel>> getSemestersById(String id) async {
    List<DocumentSnapshot> result = await _firebaseService.getFilterData(
      collectionName: CollectionName.semesters,
      orderBy: "name",
      field: "departmentId",
      id: id,
    );
    List<SemesterModel> semesters = [];

    for (var element in result) {
      SemesterModel semesterModel =
          SemesterModel.fromJson(element.data() as Map<String, dynamic>);
      semesters.add(semesterModel);
    }

    return semesters;
  }
}
