// import 'dart:developer';
// import 'package:chateo/auth/provider/auth_provider.dart';
// import 'package:chateo/models/message_model/message_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ChatProvider extends ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   List<MessageModel> _messages = [];
//   List<MessageModel> get messages => _messages;

// //  send messages function
//   Future<void> sendMessage(MessageModel message, BuildContext context) async {
//     log('Message details: fromId=${message.fromId}, toId=${message.toId}, msg=${message.msg}');
//     log('message send');
//     try {
//       final pro = Provider.of<Authpro>(context, listen: false);
//       if (message.fromId == null || message.toId == null) {
//         log('Error: fromId or toId is null');
//         return;
//       }
//       MessageModel messageModel = message.copyWith(
//           id: DateTime.now().millisecondsSinceEpoch.toString());
//       final docRef = FirebaseFirestore.instance
//           .collection('chats')
//           .doc(message.chatId)
//           .collection('messages')
//           .doc(messageModel.id);
//       await docRef.set(messageModel.toJson());
//       notifyListeners();
//     } catch (e) {
//       log('Error sending message: $e');
//     }
//   }

//   //  rec msg function
//   Future<void> fetchMessages(String chatId, BuildContext context) async {
//     final authProvider = Provider.of<Authpro>(context, listen: false);
//     final currentUserId = authProvider.user?.userId;

//     if (currentUserId == null) {
//       log('User ID is null. Cannot fetch messages.');
//       return;
//     }

//     final roomId = currentUserId.compareTo(chatId) < 0
//         ? "${currentUserId}_$chatId"
//         : "${chatId}_$currentUserId";

//     try {
//       final querySnapshot = await _firestore
//           .collection('chats')
//           .doc(roomId)
//           .collection("messages")
//           .get();

//       _messages = querySnapshot.docs.map((doc) {
//         var data = doc.data();

//         // Update read status locally
//         final messageId = doc.id;
//         messageReadStatus[messageId] = data['read'] ?? false;

//         // Handle conversions
//         if (data['read'] is! bool) {
//           data['read'] = data['read'] == true; // Convert to bool
//         }
//         if (data['sent'] is Timestamp) {
//           data['sent'] = (data['sent'] as Timestamp).millisecondsSinceEpoch;
//         }

//         return MessageModel.fromJson(data);
//       }).toList();

//       // Sort locally after fetching
//       _messages.sort((a, b) => a.sent.compareTo(b.sent));

//       log('Fetched ${_messages.length} messages');
//       notifyListeners();
//     } catch (e) {
//       log("Error fetching messages: $e");
//     }
//   }

// //  message read function

//   Future<void> updateMessageReadStatus(String chatId, String messageId) async {
//     try {
//       await _firestore
//           .collection('chats')
//           .doc(chatId)
//           .collection('messages')
//           .doc(messageId)
//           .update({'read': true});
//       log('Message read status updated for messageId: $messageId');
//     } catch (e) {
//       log('Error updating read status: $e');
//     }
//   }
// }

// // static Future<void> updateMessageReadStatus(String messageId) async {
//   //   await FirebaseFirestore.instance.collection('chats').doc(messageId).update({
//   //     'read': true,
//   //   });
//   // }
import 'dart:developer';

import 'package:chateo/auth/provider/auth_provider.dart';
import 'package:chateo/models/message_model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<MessageModel> _messages = [];
  List<MessageModel> get messages => _messages;

  // Map to track read status
  Map<String, bool> messageReadStatus = {};

  // Send message function
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
      final docRef = _firestore
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

  // Fetch messages function
  Future<void> fetchMessages(String chatId, BuildContext context) async {
    final authProvider = Provider.of<Authpro>(context, listen: false);
    final currentUserId = authProvider.user?.userId;

    if (currentUserId == null) {
      log('User ID is null. Cannot fetch messages.');
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

        // Update read status locally
        final messageId = doc.id;
        messageReadStatus[messageId] = data['read'] ?? false;

        // Handle conversions
        if (data['read'] is! bool) {
          data['read'] = data['read'] == true; // Convert to bool
        }
        if (data['sent'] is Timestamp) {
          data['sent'] = (data['sent'] as Timestamp).millisecondsSinceEpoch;
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

  // Update message read status
  Future<void> updateMessageReadStatus(String chatId, String messageId) async {
    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .update({'read': true});

      // Update local state
      messageReadStatus[messageId] = true;
      notifyListeners();

      log('Message read status updated for messageId: $messageId');
    } catch (e) {
      log('Error updating read status: $e');
    }
  }
}
