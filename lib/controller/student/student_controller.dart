import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/controller/nomination_controller.dart';
import 'package:online_voting_system/data/model/student_model.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/utility/snackbar.dart';

class StudentController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  NominationController nominationController = Get.put(NominationController());

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController admissionNo = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  Rx<StudentModel> studentModel = StudentModel().obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    refreshData();
    super.onInit();
  }

  Future<void> refreshData() async {
    loading.value = true;

    String id = Get.parameters['id'] ?? "";

    if (id.isNotEmpty) {
      Object? result = await _firebaseService.getDocById(
        id: id,
        collectionName: CollectionName.students,
      );

      if (result != null) {
        StudentModel studentData =
            StudentModel.fromJson(result as Map<String, dynamic>);

        studentModel.value = studentData;
      }
    }

    loading.value = false;
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      loading.value = true;

      Object? result = await _firebaseService.getDocById(
        id: admissionNo.text.trim(),
        collectionName: CollectionName.students,
      );

      if (result != null) {
        StudentModel studentData =
            StudentModel.fromJson(result as Map<String, dynamic>);

        String dob = DateFormat("ddMMyyyy").format(studentData.dob!);

        if (dob == dateOfBirth.text) {
          showSnackBar(context: context, text: "Successfully loggedIn");

          studentModel.value = studentData;
          Get.toNamed(
            "/StudentDashboard",
            arguments: studentData,
            parameters: {"id": studentData.admissionNo},
          );

          nominationController.checkNominationStatus();
        } else {
          showSnackBar(context: context, text: "Wrong password");
        }
      } else {
        showSnackBar(context: context, text: "Invalid admission no");
      }

      loading.value = false;
    }
  }
}
