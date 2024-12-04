import 'package:chateo/Screen/chat_screen/widget/chat_container.dart';
import 'package:chateo/Screen/chat_screen/widget/chat_text_form.dart';
import 'package:chateo/utils/colors.dart';
import 'package:chateo/utils/images.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;
  const ChatScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleSpacing: 5,
        toolbarHeight: 80,
        // leading: Icon(Icons.arrow_back),
        title: Row(
          children: [
            Stack(children: [
              const CircleAvatar(
                backgroundImage: AssetImage(AppImage.profileimage),
                maxRadius: 20,
              ),
              Positioned(
                top: 30,
                left: 33,
                child: Container(
                  height: 5,
                  width: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.activecontainerColor,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
            ]),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'saad Zafar dost',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'active now',
                  style: TextStyle(fontSize: 10),
                )
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(
                      Icons.videocam_outlined,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 15,
                ),
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 15,
                ),
                PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry>[
                        const PopupMenuItem(child: Text('View contact')),
                        const PopupMenuItem(
                            child: Text('Media, link and docs')),
                        const PopupMenuItem(child: Text('search')),
                        const PopupMenuItem(child: Text('Mute notifications')),
                        const PopupMenuItem(child: Text('Wallpaper')),
                      ];
                    },
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ))
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ChatContainer(
                  chatId: chatId,
                ),
              ],
            ),
          ),
          ChatTextForm(
            chatId: chatId,
          ),
        ],
      ),
    );
  }
}
