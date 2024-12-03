import 'dart:developer';

import 'package:chateo/models/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> allUser = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  getUsers(context, String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection("users")
          .where("userId", isNotEqualTo: userId)
          .get();
      allUser = snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
      log(allUser.toString());
      notifyListeners();
    } catch (e) {
      log('error is: $e');
    }
  }
}
