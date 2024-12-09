import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:chateo/Screen/settings_screen/settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  File? _selectedImage;
  Uint8List? profileImage;

  @override
  void initState() {
    super.initState();
    fetchProfileImage();
    _fetchUserName();
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
      final userDocRef = FirebaseFirestore.instance.collection('user').doc(user.uid);
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
      final userDocRef = FirebaseFirestore.instance.collection('user').doc(user.uid);
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

  Future<void> _fetchUserName() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        log("User is not logged in.");
        return;
      }

      final userDoc =
      await FirebaseFirestore.instance.collection('user').doc(userId).get();

      if (userDoc.exists) {
        final userData = userDoc.data();
        final userName = userData?['fullname'] ?? '';
        log("Fetched user name: $userName");
        _nameController.text = userName;
      } else {
        log("User document does not exist.");
      }
    } catch (e) {
      log("Failed to fetch user name: $e");
    }
  }


  void saveChanges() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      log("User is not authenticated");
      return;
    }

    final newName = _nameController.text.trim();
    final newPassword = _newPassword.text.trim();
    final confirmPassword = _confirmPassword.text.trim();

    try {
      if (newName.isNotEmpty) {
        await FirebaseFirestore.instance.collection('user').doc(user.uid).update({
          'fullname': newName,
        });
        log("Fullname updated successfully.");
      }

      // Update password
      if (newPassword.isNotEmpty && newPassword == confirmPassword) {
        await FirebaseFirestore.instance.collection('user').doc(user.uid).update({
          'password': newPassword,
        });
        log("Password updated successfully.");
      } else if (newPassword.isNotEmpty) {
        log("New password and confirmation password do not match.");
      }

      // Navigate to Settings screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );}
    } catch (e) {
      log("Error updating profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        scrolledUnderElevation: 0,
        elevation: 0,
        primary: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
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
                        child: const Center(child: Icon(Icons.person,size: 25,)),
                      ),
                    ),
        
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: (){
                          pickAndStoreProfileImage();
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 20),
        
              // Name Text and TextField
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Name: ', style: TextStyle(
                      fontFamily: 'mulish',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
        
              // New Password Text and TextField
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('New Password: ', style: TextStyle(
                      fontFamily: 'mulish',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextField(
                      controller: _newPassword,
                      decoration: InputDecoration(
                        hintText: 'Enter your new password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
        
              // Confirm Password Text and TextField
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Confirm Password: ', style: TextStyle(
                      fontFamily: 'mulish',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextField(
                      controller: _confirmPassword,
                      decoration: InputDecoration(
                        hintText: 'Confirm password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (){
                    saveChanges();
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width*0.9,
                    color: Colors.blue,
                    child: const Center(
                      child: Text('Save Changes',style: TextStyle(
                          fontFamily: 'mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
