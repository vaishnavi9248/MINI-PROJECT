import 'package:get/get.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/data/model/main_info_model.dart';
import 'package:online_voting_system/services/firebase_service.dart';

class CommonController extends GetxController {
  final FirebaseService firebaseService = FirebaseService();

  Rx<MainInfoModel> mainInfoModel = MainInfoModel().obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    getMainInfo();
    super.onInit();
  }

  Future<void> getMainInfo() async {
    loading.value = true;

    Object? result = await firebaseService.getMainInfo();

    if (result != null) {
      MainInfoModel data =
          MainInfoModel.fromJson(result as Map<String, dynamic>);
      mainInfoModel.value = data;
    }
    loading.value = false;
  }

  Future<void> updateField(data) async {
    loading.value = true;
    await firebaseService.updateDocById(
      collectionName: CollectionName.commonCollection,
      id: "mainInfo",
      data: data,
    );
    getMainInfo();
  }
}
