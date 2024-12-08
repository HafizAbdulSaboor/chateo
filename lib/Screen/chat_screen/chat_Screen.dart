import 'dart:convert';
import 'dart:typed_data';
import 'package:chateo/Screen/chat_screen/widget/chat_container.dart';
import 'package:chateo/Screen/chat_screen/widget/chat_text_form.dart';
import 'package:chateo/models/user_model/user_model.dart';
import 'package:chateo/utils/colors.dart';
import 'package:chateo/utils/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final UserModel user;

  const ChatScreen({super.key, required this.chatId, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Uint8List? profileImage;

  @override
  void initState() {
    super.initState();
    fetchUserImage();
  }

  Future<void> fetchUserImage() async {
    try {
      final userDocRef =
      FirebaseFirestore.instance.collection('user').doc(widget.user.userId);
      final docSnapshot = await userDocRef.get();

      if (docSnapshot.exists) {
        final picBase64 = docSnapshot['pic'] as String?;
        if (picBase64 != null && picBase64.isNotEmpty) {
          setState(() {
            profileImage = base64Decode(picBase64);
          });
        }
      }
    } catch (e) {
      print('Error fetching user image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleSpacing: 1,
        toolbarHeight: 80,
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: profileImage != null
                      ? MemoryImage(profileImage!)
                      : const AssetImage(AppImage.profileimage)
                  as ImageProvider,
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
              ],
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.fullname,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 14),
                ),
                const Text(
                  'active now',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              _buildIconButton(Icons.videocam_outlined),
              const SizedBox(width: 15),
              _buildIconButton(Icons.phone),
              const SizedBox(width: 15),
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry>[
                    const PopupMenuItem(child: Text('View contact')),
                    const PopupMenuItem(
                        child: Text('Media, link and docs')),
                    const PopupMenuItem(child: Text('Search')),
                    const PopupMenuItem(child: Text('Mute notifications')),
                    const PopupMenuItem(child: Text('Wallpaper')),
                  ];
                },
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatContainer(chatId: widget.chatId),
          ),
          ChatTextForm(chatId: widget.chatId),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
