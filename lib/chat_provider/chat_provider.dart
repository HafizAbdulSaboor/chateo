import 'dart:developer';

import 'package:chateo/models/message_model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ChatProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<MessageModel> _messages = [];
  List<MessageModel> get messages => _messages;
  // message fetch

  // Future<void> fetchMessages(String chatId) async {
  //   try {
  //     final querySnapshot = await _firestore
  //         .collection('messages')
  //         .where('chatId', isEqualTo: chatId)
  //         .orderBy('sent', descending: false)
  //         .get();

  //     _messages = querySnapshot.docs
  //         .map((doc) => MessageModel.fromJson(doc.data()))
  //         .toList();
  //     notifyListeners();
  //   } catch (e) {
  //     log("Error fetch message: $e");
  //   }
  // }
  Future<void> fetchMessages(String chatId) async {
    log('message not be fetch');
    try {
      final querySnapshot = await _firestore
          .collection('messages')
          .where('fromId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .where('toId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy('sent', descending: false)
          .get();

      _messages = querySnapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
    } catch (e) {
      log("Error fetching messages: $e");
    }
  }

  Future<void> sendMessage(MessageModel message) async {
    log('message send');
    try {
      final docRef = FirebaseFirestore.instance
          .collection('messages')
          .doc()
          .collection('chatroom')
          .doc();
      await docRef.set({
        'fromId': message.fromId,
        'toId': message.toId,
        'msg': message.msg,
        'sent': message.sent,
        'read': message.read,
        'messageType': message.messageType.toString(),
      });
      notifyListeners();
    } catch (e) {
      log('Error sending message: $e');
    }
  }

  String generateMessageId() {
    return FirebaseFirestore.instance.collection('messages').doc().id;
  }
}
