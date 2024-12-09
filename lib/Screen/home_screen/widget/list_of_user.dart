import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:chateo/Screen/chat_screen/chat_Screen.dart';
import 'package:chateo/apis/auth_apis.dart';
import 'package:chateo/auth/provider/auth_provider.dart';
import 'package:chateo/models/user_model/user_model.dart';
import 'package:chateo/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ListOfUser extends StatefulWidget {
  const ListOfUser({super.key});

  @override
  State<ListOfUser> createState() => _ListOfUserState();
}

class _ListOfUserState extends State<ListOfUser> {
  Future<Uint8List?> fetchProfileImageFromFirestore(String userId) async {
    try {
      final userDocRef = FirebaseFirestore.instance.collection('user').doc(userId);
      final docSnapshot = await userDocRef.get();

      if (docSnapshot.exists) {
        final picBase64 = docSnapshot['pic'] as String?;
        if (picBase64 != null && picBase64.isNotEmpty) {
          return base64Decode(picBase64);
        } else {
          log("Image data is empty or null for userId: $userId");
        }
      }
    } catch (e) {
      log("Error fetching image for userId $userId: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Authpro>(context, listen: false);

    return StreamBuilder(
      stream: Apis.firestore
          .collection("user")
          .where("userId", isNotEqualTo: provider.user.userId)
          .snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return const Center(child: CircularProgressIndicator());

          case ConnectionState.active:
          case ConnectionState.done:
            final data = snapshot.data?.docs;
            final List<UserModel> list =
                data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GestureDetector(
                    onTap: () {
                      final currentUserId = provider.user.userId;
                      final recipientId = list[index].userId;

                      if (currentUserId == null || recipientId == null) {
                        log('Error: User ID or recipient ID is null.');
                        return;
                      }

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            user: list[index],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.bodercolor,
                              width: 3,
                            ),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(80)),
                            color: AppColors.whiteColor,
                          ),
                          child: FutureBuilder<Uint8List?>(
                            future: fetchProfileImageFromFirestore(list[index].userId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: ClipOval(
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                return ClipOval(
                                  child: Image.memory(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                    width: 60, // Adjust size as needed
                                    height: 60,
                                  ),
                                );
                              } else {
                                return ClipOval(
                                  child: Container(
                                    width: 60, // Adjust size as needed
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.person, // Use a placeholder icon instead of an image
                                      color: Colors.grey.shade700,
                                      size: 30, // Adjust icon size
                                    ),
                                  ),
                                );
                              }
                            },
                          ),

                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    list[index].fullname,
                                    style: const TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.apptextColor,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text(
                                      '27/01/2023',
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'It’s not even final yet, he is not right for...',
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
