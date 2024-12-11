import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingServices{
  static final FirebaseMessaging _message = FirebaseMessaging.instance;
  static Future<String?> getToken() async {
    try {
      String? token = await _message.getToken();
      if (token == null) {
        log('Token retrieval failed: token is null');
      } else {
        log('------token: $token');
      }
      return token;
    } catch (e) {
      log('Error retrieving token: $e');
      return null;
    }
  }

}