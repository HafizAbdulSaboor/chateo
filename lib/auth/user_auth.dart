import 'dart:developer';
import 'package:chateo/auth/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import '../apis/auth_apis.dart';
import '../models/user_model/user_model.dart';

class AuthServices {
  static final auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;
  static final storage = FirebaseStorage.instance;
  late User user;
  //  create user

  static Future<String> createUser(
    String email,
    String password,
    String fullname,
  ) async {
    try {
      return auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        UserModel userData = UserModel(
            email: email,
            fullname: fullname,
            PushToken: '',
            password: password,
            userId: value.user?.uid ?? '');
        await Apis.firestore
            .collection("user")
            .doc(value.user?.uid)
            .set(userData.toJson());
        return ('register');
      });
    } catch (e) {
      log('Register error $e');
      return ('register error');
    }
  }

  // sigin user
  static Future<String> signin(String email, String password, context) async {
    var provider = Provider.of<Authpro>(context, listen: false);
    try {
      return await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        // var data =
        //     await firestore.collection("user").doc(value.user?.uid).get();
        // UserModel user = UserModel.fromJson(data.data()!);
        provider.getSelfInfo();
        return "success";
      });
    } catch (e) {
      log("erroe while creating user $e");
      throw Exception("Error while creating user");
    }
  }
}
