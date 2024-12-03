import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../apis/auth_apis.dart';
import '../../models/user_model.dart';
import '../user_auth.dart';

class Authpro extends ChangeNotifier {
  UserModel _user = UserModel();
  UserModel get user => _user;

  getUserData(
    UserModel user,
  ) {
    _user = user;
    notifyListeners();
  }

  getSelfInfo() async {
    try {
      var currentUser = AuthServices.auth.currentUser;
      if (currentUser == null) {
        print("[Error] User not authenticated.");
        return;
      }
      var currentUserId = currentUser.uid;
      log("[log] Current User ID: $currentUserId");

      var data = await AuthServices.firestore
          .collection("user")
          .doc(currentUserId)
          .get();

      if (!data.exists || data.data() == null) {
        log("[Error] No data found for the user with ID: $currentUserId");
        return;
      }

      UserModel user = UserModel.fromJson(data.data()!);
      getUserData(user);
      log("[log] Fetched User Data: ${user.toJson()}");
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        log("[Error] Firestore permission denied. Check Firestore security rules.");
      } else {
        log("[Error] An unexpected error occurred: $e");
      }
    }
  }
}
