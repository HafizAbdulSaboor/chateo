import 'dart:developer';
import 'package:chateo/auth/provider/auth_provider.dart';
import 'package:chateo/models/message_model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<MessageModel> _messages = [];
  List<MessageModel> get messages => _messages;

//  send messages function
  Future<void> sendMessage(MessageModel message, BuildContext context) async {
    log('Message details: fromId=${message.fromId}, toId=${message.toId}, msg=${message.msg}');
    log('message send');
    try {
      final pro = Provider.of<Authpro>(context, listen: false);
      if (message.fromId == null || message.toId == null) {
        log('Error: fromId or toId is null');
        return;
      }
      MessageModel messageModel = message.copyWith(
          id: DateTime.now().millisecondsSinceEpoch.toString());
      final docRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(message.chatId)
          .collection('messages')
          .doc(messageModel.id);
      await docRef.set(messageModel.toJson());
      notifyListeners();
    } catch (e) {
      log('Error sending message: $e');
    }
  }

  //  rec msg function
  Future<void> fetchMessages(String chatId, BuildContext context) async {
    final authProvider = Provider.of<Authpro>(context, listen: false);
    final currentUserId = authProvider.user?.userId;

    if (currentUserId == null) {
      log('User ID is null. Cannot send message.');
      return;
    }

    final roomId = currentUserId.compareTo(chatId) < 0
        ? "${currentUserId}_$chatId"
        : "${chatId}_$currentUserId";
    try {
      final querySnapshot = await _firestore
          .collection('chats')
          .doc(roomId)
          .collection("messages")
          .get();
      _messages = querySnapshot.docs.map((doc) {
        var data = doc.data();
        var sent = data['sent'];
        // If sent is a Timestamp, convert it to DateTime
        if (sent is Timestamp) {
          sent = sent.toDate(); // Convert Timestamp to DateTime
        }
        return MessageModel.fromJson(data);
      }).toList();
      // Sort locally after fetching
      _messages.sort((a, b) => a.sent.compareTo(b.sent));

      log('Fetched ${_messages.length} messages');
      notifyListeners();
    } catch (e) {
      log("Error fetching messages: $e");
    }
  }

//  message read function
  static Future<void> updateMessageReadStatus(String messageId) async {
    await FirebaseFirestore.instance.collection('chats').doc(messageId).update({
      'read': true,
    });
  }
}
