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

  // getSelfInfo() async {
  //   try {
  //     var currentUser = AuthServices.auth.currentUser;
  //     if (currentUser == null) {
  //       log("[Error] User not authenticated.");
  //       return;
  //     }
  //     var currentUserId = currentUser.uid;
  //     log("[log] Current User ID: $currentUserId");

  //     var data = await AuthServices.firestore
  //         .collection("user")
  //         .doc(currentUserId)
  //         .get();

  //     if (!data.exists || data.data() == null) {
  //       log("[Error] No data found for the user with ID: $currentUserId");
  //       return;
  //     }

  //     UserModel user = UserModel.fromJson(data.data()!);
  //     getUserData(user);
  //     log("[log] Fetched User Data: ${user.toJson()}");
  //   } catch (e) {
  //     if (e is FirebaseException && e.code == 'permission-denied') {
  //       log("[Error] Firestore permission denied. Check Firestore security rules.");
  //     } else {
  //       log("[Error] An unexpected error occurred: $e");
  //     }
  //   }
  // }
}
