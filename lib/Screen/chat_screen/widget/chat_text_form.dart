import 'dart:developer';

import 'package:chateo/Screen/chat_screen/provider/chat_text_field_provider.dart';
import 'package:chateo/auth/provider/auth_provider.dart';
import 'package:chateo/chat_provider/chat_provider.dart';
import 'package:chateo/models/message_model/message_model.dart';
import 'package:chateo/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatTextForm extends StatefulWidget {
  final String chatId;

  const ChatTextForm({super.key, required this.chatId});

  @override
  _ChatTextFormState createState() => _ChatTextFormState();
}

class _ChatTextFormState extends State<ChatTextForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputFieldProvider = Provider.of<ChatTextFieldProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final authProvider = Provider.of<Authpro>(context, listen: false);

    void _sendMessage() {
      if (_controller.text.trim().isEmpty) return;

      final currentUserId = authProvider.user?.userId;
      if (currentUserId == null) {
        log('User ID is null. Cannot send message.');
        return;
      }
      final chatId = currentUserId.compareTo(widget.chatId) < 0
          ? "$currentUserId${widget.chatId}"
          : "${widget.chatId}_$currentUserId";

      final message = MessageModel(
          id: '',
          fromId: currentUserId,
          toId: widget.chatId,
          msg: _controller.text.trim(),
          read: false,
          sent: DateTime.now(),
          messageType: MessageType.text,
          chatId: chatId);

      chatProvider.sendMessage(message, context);
      _controller.clear();
      inputFieldProvider.updateFocus(false);
    }

    return Container(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const SizedBox(width: 10),
            const Icon(CupertinoIcons.paperclip),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 60,
                child: TextFormField(
                  controller: _controller,
                  maxLines: null,
                  onChanged: (value) {
                    inputFieldProvider.updateFocus(value.isNotEmpty);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBorder: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: AppColors.chatfieldColor,
                    hintText: 'Write your message',
                    hintStyle:
                        const TextStyle(color: AppColors.chathinttextColor),
                    suffixIcon: const Icon(
                      Icons.copy_outlined,
                      color: AppColors.chathinttextColor,
                      size: 17,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            if (inputFieldProvider.isFocused)
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff20A090),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            const SizedBox(width: 10),
            if (!inputFieldProvider.isFocused)
              const Icon(
                Icons.camera_alt_outlined,
                color: Color(0xff000E08),
              ),
            const SizedBox(width: 10),
            if (!inputFieldProvider.isFocused)
              const Icon(
                Icons.mic_none,
                color: Color(0xff000E08),
              ),
          ],
        ),
      ),
    );
  }
}














// import 'package:chateo/Screen/chat_screen/provider/chat_text_field_provider.dart';
// import 'package:chateo/utils/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ChatTextForm extends StatelessWidget {
//   const ChatTextForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final inputFieldProvider = Provider.of<ChatTextFieldProvider>(context);

//     return Container(
//       height: 80,
//       // color: AppColors.whiteColor,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Row(
//           children: [
//             const SizedBox(width: 10),
//             const Icon(CupertinoIcons.paperclip),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Container(
//                 height: 60,
//                 child: TextFormField(
//                   maxLines: null,
//                   onChanged: (value) {
//                     inputFieldProvider.updateFocus(value.isNotEmpty);
//                   },
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     disabledBorder: InputBorder.none,
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     filled: true,
//                     fillColor: AppColors.chatfieldColor,
//                     hintText: 'Write your message',
//                     hintStyle:
//                         const TextStyle(color: AppColors.chathinttextColor),
//                     suffixIcon: const Icon(
//                       Icons.copy_outlined,
//                       color: AppColors.chathinttextColor,
//                       size: 17,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             if (inputFieldProvider.isFocused)
//               Container(
//                 height: 40,
//                 width: 40,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: const Color(0xff20A090),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Icon(
//                   Icons.send,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               ),
//             const SizedBox(width: 10),
//             if (!inputFieldProvider.isFocused)
//               const Icon(
//                 Icons.camera_alt_outlined,
//                 color: Color(0xff000E08),
//               ),
//             const SizedBox(width: 10),
//             if (!inputFieldProvider.isFocused)
//               const Icon(
//                 Icons.mic_none,
//                 color: Color(0xff000E08),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
