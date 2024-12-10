import 'dart:developer';
import 'package:chateo/auth/provider/auth_provider.dart';
import 'package:chateo/chat_provider/chat_provider.dart';
import 'package:chateo/models/message_model/message_model.dart';
import 'package:chateo/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatContainer extends StatelessWidget {
  final String chatId; // ID of the current chat
  const ChatContainer({super.key, required this.chatId});
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final messages = chatProvider.messages;
    final authProvider = Provider.of<Authpro>(context);

    chatProvider.fetchMessages(chatId, context);

    return messages.isEmpty
        ? const Center(child: Text('No messages yet'))
        : ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final isSentByMe = message.fromId == authProvider.user.userId;
              return isSentByMe
                  ? _sendMessage(MediaQuery.of(context).size, message)
                  : _reciveMessage(MediaQuery.of(context).size, message);
            },
          );
  }

  // Widget for sent messages
  Widget _sendMessage(Size mq, MessageModel message) {
    return Padding(
      padding: EdgeInsets.only(right: mq.width * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(left: mq.width * .4),
            child: Container(
              margin: EdgeInsets.only(top: mq.width * .04),
              padding: EdgeInsets.all(mq.width * .04),
              decoration: BoxDecoration(
                color: AppColors.chatcontainerColor.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Text(
                message.msg,
                style: const TextStyle(
                  fontFamily: 'mulish',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${DateTime.parse(message.sent).hour}:${DateTime.parse(message.sent).minute}  ${getTimeFormat(DateTime.parse(message.sent).hour)}",
                style: const TextStyle(
                  fontFamily: 'hind',
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: AppColors.chattimeColor,
                ),
              ),
              const SizedBox(width: 3),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(chatId) // Use the current chat ID
                    .collection('messages')
                    .doc(message.id) // Use the message ID
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Icon(
                      Icons.check,
                      size: 15,
                      color: Colors.grey,
                    );
                  }

                  if (snapshot.hasError) {
                    log("Error in StreamBuilder: ${snapshot.error}");
                    return const Icon(
                      Icons.check,
                      size: 15,
                      color: Colors.grey,
                    );
                  }

                  if (snapshot.hasData && snapshot.data?.data() != null) {
                    final data = snapshot.data!.data() as Map<String, dynamic>;
                    final isRead = data['read'] ?? false; // Default to false if 'read' is null
                    return Icon(
                      isRead ? Icons.done_all : Icons.check,
                      size: 15,
                      color: isRead ? Colors.blue : Colors.grey,
                    );
                  }

                  // Handle case where the document does not exist or has no data
                  return const Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.grey,
                  );
                },
              ),

            ],
          ),
        ],
      ),
    );
  }

  String getTimeFormat(int hour) {
    if (hour > 12) {
      return "PM";
    } else {
      return "AM";
    }
  }

  // Widget for received messages
  Widget _reciveMessage(
    Size mq,
    MessageModel message,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: mq.width * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: mq.width * .4),
            child: Container(
              margin: EdgeInsets.only(top: mq.width * .04),
              padding: EdgeInsets.all(mq.width * .04),
              decoration: const BoxDecoration(
                color: AppColors.reciveContainer,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                message.msg,
                style: const TextStyle(
                  fontFamily: 'mulish',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${DateTime.parse(message.sent).hour}:${DateTime.parse(message.sent).minute}${getTimeFormat(DateTime.parse(message.sent).hour)}",
            style: const TextStyle(
              fontFamily: 'hind',
              fontSize: 9,
              fontWeight: FontWeight.w400,
              color: AppColors.chattimeColor,
            ),
          ),
        ],
      ),
    );
  }
}
