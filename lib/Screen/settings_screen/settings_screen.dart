import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:chateo/auth/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chateo/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import '../../apis/auth_apis.dart';
import '../edit_profile/edit_profile_screen.dart';
import '../loginscreen/login_screen.dart';
import 'dart:convert';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? _selectedImage;
  Uint8List? profileImage;

  @override
  void initState() {
    super.initState();
    fetchProfileImage();
  }

  Future<void> fetchProfileImage() async {
    final image = await fetchProfileImageFromFirestore();
    setState(() {
      profileImage = image;
    });
  }

  Future<void> pickAndStoreProfileImage() async {
    final imageBytes = await pickImage();
    if (imageBytes != null) {
      await storeImageInFirestore(imageBytes);
      fetchProfileImage();
    }
  }

  Future<Uint8List?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      return imageBytes;
    }
    return null;
  }

  Future<void> storeImageInFirestore(Uint8List imageBytes) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      log("User not authenticated");
      return;
    }
    try {
      String base64Image = base64Encode(imageBytes);
      final userDocRef =
          FirebaseFirestore.instance.collection('user').doc(user.uid);
      await userDocRef.update({'pic': base64Image});
      log("Image stored successfully as Base64 string in Firestore.");
    } catch (e) {
      log("Error storing image in Firestore: $e");
    }
  }

  Future<Uint8List?> fetchProfileImageFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      log("User not authenticated");
      return null;
    }

    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('user').doc(user.uid);
      final docSnapshot = await userDocRef.get();

      if (docSnapshot.exists) {
        final picBase64 = docSnapshot['pic'] as String?;
        if (picBase64 != null && picBase64.isNotEmpty) {
          Uint8List imageBytes = base64Decode(picBase64);
          return imageBytes;
        } else {
          log("Image data is empty or null");
        }
      }
    } catch (e) {
      log("Error fetching image from Firestore: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<String> title = [
      'Edit Profile',
      'Accounts',
      'Privacy',
      'Chats',
      'Notifications',
      'Data and Storage',
      'Language',
    ];
    List<String> subTitle = [
      'Name, Profile Pic, Password',
      'Number, email, security',
      'Block contacts, message encryption',
      'Wallpapers, chat history, archived',
      'Call tones, messages, group chats',
      'Backup, network usage',
      'English (device language)'
    ];
    List<Icon> icons = [
      const Icon(Icons.edit),
      const Icon(Icons.key),
      const Icon(Icons.lock),
      const Icon(Icons.chat),
      const Icon(Icons.notifications),
      const Icon(Icons.cloud),
      const Icon(Icons.public)
    ];
    var provider = Provider.of<Authpro>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        primary: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.black)),
        title: const Text('Settings',
            style: TextStyle(
                fontFamily: 'mulish',
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor)),
        actions: [
          GestureDetector(
            onTap: () {
              Apis.auth.signOut().then((value) => Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen())));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 19.0),
              child: Icon(Icons.logout, color: AppColors.blackColor),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: profileImage != null
                      ? Image.memory(
                          profileImage!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                              child: Icon(
                            Icons.person,
                            size: 25,
                          )),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(provider.user.fullname,
                style: const TextStyle(
                    fontFamily: 'mulish',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor)),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blueGrey),
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Do not disturb!',
                      style: TextStyle(
                          fontFamily: 'mulish',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white60)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: title.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        if (title[index] == 'Edit Profile') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen()));
                        }
                      },
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: icons[index],
                      ),
                      title: Text(title[index],
                          style: const TextStyle(
                              fontFamily: 'mulish',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      subtitle: Text(subTitle[index],
                          style: const TextStyle(
                              fontFamily: 'mulish',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.blueGrey)),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
