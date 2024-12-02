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
        .collection("users")
        .doc(AuthServices.auth.currentUser?.uid)
        .get();
    UserModel user = UserModel.fromJson(data.data()!);
    getUserData(user);
  }
}
