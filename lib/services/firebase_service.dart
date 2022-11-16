import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/utility/custom_print.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream getCollectionStream({
    required String collectionName,
    required String orderBy,
  }) =>
      _db.collection(collectionName).orderBy(orderBy).snapshots();

  Stream getStudentDocs({
    required String courseId,
    required String semesterId,
  }) =>
      _db
          .collection(CollectionName.students)
          .where("courseId", isEqualTo: courseId)
          .where("semesterId", isEqualTo: semesterId)
          .orderBy("id")
          .snapshots();

  Stream getNominationsDocs({
    required String courseId,
    required String semesterId,
  }) =>
      _db
          .collection(CollectionName.nomination)
          .where("candidateCourse", isEqualTo: courseId)
          .where("candidateSemester", isEqualTo: semesterId)
          .orderBy("candidateId")
          .snapshots();

  Stream getResultList({
    required String courseId,
    required String semesterId,
  }) =>
      _db
          .collection(CollectionName.nomination)
          .where("candidateCourse", isEqualTo: courseId)
          .where("candidateSemester", isEqualTo: semesterId)
          .where("status", isEqualTo: "ACCEPTED")
          .orderBy("count")
          .snapshots();

  Stream getCollectionStreamOrderBy({
    required String collectionName,
    required String orderBy,
    required String orderByNew,
  }) =>
      _db
          .collection(collectionName)
          .orderBy(orderBy)
          .orderBy(orderByNew)
          .snapshots();

  Future<List<DocumentSnapshot>> getData({
    required String collectionName,
    required String orderBy,
  }) async {
    return await _db
        .collection(collectionName)
        .orderBy(orderBy)
        .get()
        .then((value) => value.docs);
  }

  Future<List<DocumentSnapshot>> getFilterData({
    required String collectionName,
    required String orderBy,
    required String field,
    required String id,
  }) async {
    return await _db
        .collection(collectionName)
        .where(field, isEqualTo: id)
        .orderBy(orderBy)
        .get()
        .then((value) => value.docs);
  }

  Future<bool> addDoc({
    required String collectionName,
    required Map<String, dynamic> data,
  }) async {
    try {
      CollectionReference collectionReference = _db.collection(collectionName);
      String id = collectionReference.doc().id;
      data.addAll({"id": id});

      await collectionReference.doc(id).set(data);

      debugPrint("document on $collectionName as data $data added");

      return true;
    } catch (e) {
      customPrint("addDoc error $e");

      return false;
    }
  }

  Future<bool> addDocById({
    required String collectionName,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _db.collection(collectionName).doc(id).set(data);

      debugPrint("document on $collectionName as data $data added");

      return true;
    } catch (e) {
      customPrint("addDocById error $e");

      return false;
    }
  }

  Future<bool> updateDocById({
    required String collectionName,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _db.collection(collectionName).doc(id).update(data);

      debugPrint("document on $collectionName as updated $data added");

      return true;
    } catch (e) {
      customPrint("addDocById error $e");

      return false;
    }
  }

  Future<bool> deleteDoc({
    required String collectionName,
    required String id,
  }) async {
    try {
      await _db.collection(collectionName).doc(id).delete();

      debugPrint("document on $collectionName as id $id deleted");

      return true;
    } catch (e) {
      customPrint("deleteDOc error $e");
      return false;
    }
  }

  Future<Object?> getDocById({
    required String id,
    required String collectionName,
  }) async {
    try {
      DocumentSnapshot data =
          await _db.collection(collectionName).doc(id).get();

      debugPrint(
          "document on $collectionName, data: ${data.data() as Map<String, dynamic>}");

      return data.data();
    } catch (e) {
      customPrint("getDocById error $e");
      return null;
    }
  }

  Future<Object?> getMainInfo() async {
    try {
      DocumentSnapshot data = await _db
          .collection(CollectionName.commonCollection)
          .doc("mainInfo")
          .get();

      debugPrint(
          "document on commonCollection, data: ${data.data() as Map<String, dynamic>}");

      return data.data();
    } catch (e) {
      customPrint("getMainInfo error $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getAdminInfo() async {
    try {
      DocumentSnapshot data = await _db
          .collection(CollectionName.commonCollection)
          .doc("adminCredentials")
          .get();

      debugPrint(
          "document on commonCollection, data: ${data.data() as Map<String, dynamic>}");

      return data.data() as Map<String, dynamic>;
    } catch (e) {
      customPrint("getMainInfo error $e");
      return null;
    }
  }

  Future<void> incrementCount(String id) async {
    await _db
        .collection(CollectionName.nomination)
        .doc(id)
        .update({"count": FieldValue.increment(1)});
  }
}
