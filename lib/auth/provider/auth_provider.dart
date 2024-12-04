import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../apis/auth_apis.dart';
import '../../models/user_model/user_model.dart';
import '../user_auth.dart';

class Authpro extends ChangeNotifier {
  UserModel _user = UserModel();
  UserModel get user => _user;

  getUserData(
    UserModel user,
  ) {
    _user = user;
    log("user data local $_user");
    notifyListeners();
  }

  getSelfInfo() async {
    log("called");
    try {
      var currentUser = AuthServices.auth.currentUser;
      var userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUser?.uid)
          .get();
      log("user data ${userDoc.data()}");
      getUserData(UserModel.fromJson(userDoc.data() ?? {}));
    } catch (e) {
      log("[Error] An unexpected error occurred: $e");
    }
  }
}
