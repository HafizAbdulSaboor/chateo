import 'dart:developer';
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
    var data = await AuthServices.firestore
        .collection("user")
        .doc(AuthServices.auth.currentUser?.uid)
        .get();
    UserModel user = UserModel.fromJson({
      ...data.data()!,
      'userId': AuthServices.auth.currentUser?.uid,
    });
    getUserData(user);
  }

  // Future<void> updateUserData(
  //     String fullname,
  //     //
  //     String phoneNumber) async {
  //   try {
  //     // Update Firestore
  //     await Apis.firestore
  //         .collection('users')
  //         .doc(user.userId) // Use _user.userId
  //         .update({
  //       'fullname': fullname,
  //       // 'email': email,
  //
  //     });

      // Update local user state
      // _user = user.copyWith(
      //     fullname: fullname,
      //     //  email: email,);
      // );

      // Notify listeners to update UI
  //     notifyListeners();
  //   } catch (e) {
  //     log("Error updating user data: $e");
  //   }
  // }
}