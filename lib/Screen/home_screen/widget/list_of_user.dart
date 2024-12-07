import 'dart:developer';
import 'package:chateo/Screen/chat_screen/chat_Screen.dart';
import 'package:chateo/Screen/chat_screen/widget/chat_text_form.dart';
import 'package:chateo/apis/auth_apis.dart';
import 'package:chateo/auth/provider/auth_provider.dart';
import 'package:chateo/models/user_model/user_model.dart';
import 'package:chateo/utils/colors.dart';
import 'package:chateo/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfUser extends StatelessWidget {
  ListOfUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Authpro>(context, listen: false);
    List<UserModel> list = [];

    return StreamBuilder(
        stream: Apis.firestore
            .collection("user")
            .where(
              "userId",
              isNotEqualTo: provider.user.userId,
            )
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            case ConnectionState.active:
            case ConnectionState.done:
              log("Current User ID: ${provider.user.userId}");
              final data = snapshot.data?.docs;
              log("Fetched Data: ${data?.map((e) => e.data())}");
              list =
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  user: list[index],
                                  chatId: '',
                                )));
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.bodercolor, width: 3),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(80)),
                              color: AppColors.whiteColor,
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(80)),
                              child: Image.asset(
                                AppImage.profileimage,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ignore: prefer_const_constructors
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
                                          color: AppColors.apptextColor),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text(
                                        '27/01/2023',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.blackColor),
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
                                      color: AppColors.subtitleColor),
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
        });
  }
}
