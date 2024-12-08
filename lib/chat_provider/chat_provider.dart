import 'dart:developer';

import 'package:chateo/auth/provider/auth_provider.dart';
import 'package:chateo/models/message_model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<MessageModel> _messages = [];
  List<MessageModel> get messages => _messages;

  Future<void> fetchMessages(String chatId) async {
    log('Fetching messages for chatId: $chatId');
    try {
      final querySnapshot = await _firestore
          .collection('messages')
          .where('chatId', isEqualTo: chatId) // Filter by chat ID
          .orderBy('sent', descending: false) // Order by timestamp
          .get();

      _messages = querySnapshot.docs
          .map((doc) =>
              MessageModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      log('Fetched ${_messages.length} messages');
      notifyListeners(); // Notify listeners to update UI
    } catch (e) {
      log("Error fetching messages: $e");
    }
  }

  Future<void> sendMessage(MessageModel message, BuildContext context) async {
    log('Message details: fromId=${message.fromId}, toId=${message.toId}, msg=${message.msg}');
    log('message send');
    try {
      final pro = Provider.of<Authpro>(context, listen: false);
      if (message.fromId == null || message.toId == null) {
        log('Error: fromId or toId is null');
        return;
      }
      final docRef = FirebaseFirestore.instance
          .collection('messages')
          .doc(pro.user.userId)
          .collection('chatroom')
          .doc(message.chatId);
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
