import 'dart:developer';

import 'package:chateo/Screen/chat_screen/provider/chat_text_field_provider.dart';
import 'package:chateo/auth/provider/auth_provider.dart';
import 'package:chateo/chat_provider/chat_provider.dart';
import 'package:chateo/models/message_model/message_model.dart';
import 'package:chateo/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  void _sendMessage() {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final authProvider = Provider.of<Authpro>(context, listen: false);

    if (_controller.text.trim().isEmpty) return;

    final currentUserId = authProvider.user?.userId;
    if (currentUserId == null) {
      log('User ID is null. Cannot send message.');
      return;
    }
    final chatId = currentUserId.compareTo(widget.chatId) < 0
        ? "${currentUserId}_${widget.chatId}"
        : "${widget.chatId}_$currentUserId";

    final message = MessageModel(
      id: '',
      fromId: currentUserId,
      toId: widget.chatId,
      msg: _controller.text.trim(),
      read: true,
      sent: DateTime.now().toString(),
      messageType: MessageType.text.name,
      chatId: chatId,
    );

    chatProvider.sendMessage(message, context);
    _controller.clear();
    // Provider.of<ChatTextFieldProvider>(context).updateFocus(false);
    Provider.of<ChatTextFieldProvider>(context, listen: false)
        .updateFocus(false);
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<ChatTextFieldProvider>(context);

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
                height: 50,
                child: TextFormField(
                  controller: _controller,
                  maxLines: null,
                  onChanged: (value) {
                    pro.updateFocus(value.trim().isNotEmpty);
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
            Consumer<ChatTextFieldProvider>(
              builder: (context, pro, child) {
                return pro.isFocused == false
                    ? const Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Color(0xff000E08),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.mic_none,
                            color: Color(0xff000E08),
                          ),
                        ],
                      )
                    : GestureDetector(
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
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
