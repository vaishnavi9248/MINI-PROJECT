import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/data/model/nomination_model.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/utility/snackbar.dart';

class NominationController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController p1AdmissionNo = TextEditingController();
  TextEditingController p1KtuId = TextEditingController();
  TextEditingController p1Name = TextEditingController();

  TextEditingController p2AdmissionNo = TextEditingController();
  TextEditingController p2KtuId = TextEditingController();
  TextEditingController p2Name = TextEditingController();

  Rx<NominationModel> nominationData = NominationModel().obs;

  RxBool loading = false.obs;
  RxBool btnLoading = false.obs;

  @override
  void onInit() {
    checkNominationStatus();
    super.onInit();
  }

  Future<void> checkNominationStatus() async {
    loading.value = true;
    nominationData.value = NominationModel();
    String id = Get.parameters['id'] ?? "";

    if (id.isNotEmpty) {
      Object? result = await _firebaseService.getDocById(
        id: id,
        collectionName: CollectionName.nomination,
      );

      if (result != null) {
        NominationModel nominationModel =
            NominationModel.fromJson(result as Map<String, dynamic>);

        nominationData.value = nominationModel;
      }
    }

    loading.value = false;
  }

  Future<void> applyNomination({
    required String id,
    required String name,
    required String course,
    required String semester,
  }) async {
    if (formKey.currentState!.validate()) {
      btnLoading.value = true;

      NominationModel nominationModel = NominationModel(
        candidateId: id,
        candidateName: name,
        candidateCourse: course,
        candidateSemester: semester,
        proposer1AdNo: p1AdmissionNo.text.trim(),
        proposer1Name: p1Name.text.trim(),
        proposer1KTUId: p1KtuId.text.trim(),
        proposer2AdNo: p2AdmissionNo.text.trim(),
        proposer2Name: p2Name.text.trim(),
        proposer2KTUId: p2KtuId.text.trim(),
        status: "APPLIED",
      );

      await _firebaseService.addDocById(
        collectionName: CollectionName.nomination,
        id: id,
        data: nominationModel.toJson(),
      );

      btnLoading.value = false;

      Get.back();
      showSnackBar(
          context: Get.context!, text: "Successfully applied your nomination");
      checkNominationStatus();
    }
  }
}
