import 'package:chateo/Screen/chat_screen/provider/chat_text_field_provider.dart';
import 'package:chateo/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatTextForm extends StatelessWidget {
  const ChatTextForm({super.key});

  @override
  Widget build(BuildContext context) {
    final inputFieldProvider = Provider.of<ChatTextFieldProvider>(context);

    return Container(
      height: 80,
      // color: AppColors.whiteColor,
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
              Container(
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
