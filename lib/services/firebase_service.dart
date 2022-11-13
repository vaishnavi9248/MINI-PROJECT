import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_system/utility/custom_print.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream getData({
    required String collectionName,
    required String orderBy,
  }) =>
      _db.collection(collectionName).orderBy("name").snapshots();

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
      customPrint("getData error $e");

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
}
