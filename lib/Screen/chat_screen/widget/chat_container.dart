import 'dart:developer';

import 'package:chateo/auth/provider/auth_provider.dart';
import 'package:chateo/chat_provider/chat_provider.dart';
import 'package:chateo/main.dart';
import 'package:chateo/models/message_model/message_model.dart';
import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ChatContainer extends StatelessWidget {
  final String chatId; // ID of the current chat

  const ChatContainer({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final messages = chatProvider.messages;
    final authProvider = Provider.of<Authpro>(context);

    // Ensure the provider fetches messages for the current chat
    chatProvider.fetchMessages(chatId);

    return Expanded(
      child: messages.isEmpty
          ? const Center(child: Text('No messages yet'))
          : ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isSentByMe = message.fromId == authProvider.user.userId;
                return isSentByMe
                    ? _sendMessage(
                        mq, message) // Replace mq with MediaQuery if necessary
                    : _reciveMessage(mq, message);
              },
            ),
    );
  }
  //  ? _sendMessage(mq, message)
  //             : _reciveMessage(mq, message);

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
            _formatTimestamp(message.sent as Timestamp),
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

  // Widget for received messages
  Widget _reciveMessage(Size mq, MessageModel message) {
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
            _formatTimestamp(message.sent as Timestamp),
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

  // Helper to format Firestore Timestamp
  String _formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}














// import 'package:chateo/auth/provider/auth_provider.dart';
// import 'package:chateo/main.dart';
// import 'package:chateo/models/message_model/message_model.dart';
// import 'package:chateo/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ChatContainer extends StatelessWidget {
//   const ChatContainer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     mq = MediaQuery.of(context).size;
//     var pro = Provider.of<Authpro>(context, listen: false);

//     return pro.user.userId == Message ? _reciveMessage() : _sendMessage();
//   }

//   // send msg container
//   Widget _sendMessage() {
//     return Padding(
//       padding: EdgeInsets.only(
//         right: mq.width * .04,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: mq.width * .4),
//             child: Container(
//               margin: EdgeInsets.only(
//                 top: mq.width * .04,
//               ),
//               padding: EdgeInsets.all(
//                 mq.width * .04,
//               ),
//               decoration: BoxDecoration(
//                   color: AppColors.chatcontainerColor.withOpacity(0.5),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                     bottomRight: Radius.circular(10),
//                   )),
//               child: const Text(
//                 "Yeah, I am...but I am a bit nervous about meeting everyone",
//                 // message.msg,
//                 style: TextStyle(
//                     fontFamily: 'mulish',
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.blackColor),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             '01:00 pm',
//             style: TextStyle(
//                 fontFamily: 'hind',
//                 fontSize: 9,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.chattimeColor),
//           ),
//         ],
//       ),
//     );
//   }

//   //
//   Widget _reciveMessage() {
//     return // recive message
//         Padding(
//       padding: EdgeInsets.only(
//         left: mq.width * .04,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(right: mq.width * .4),
//             child: Container(
//               margin: EdgeInsets.only(
//                 top: mq.width * .04,
//               ),
//               padding: EdgeInsets.all(
//                 mq.width * .04,
//               ),
//               decoration: const BoxDecoration(
//                   color: AppColors.reciveContainer,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                     bottomRight: Radius.circular(10),
//                   )),
//               child: const Text(
//                 "Yeah, I am...but I am a bit nervous about meeting everyone",
//                 // message.msg,
//                 style: TextStyle(
//                     fontFamily: 'mulish',
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.blackColor),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             '01:00 pm',
//             style: TextStyle(
//                 fontFamily: 'hind',
//                 fontSize: 9,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.chattimeColor),
//           ),
//         ],
//       ),
//     );
//   }
// }
