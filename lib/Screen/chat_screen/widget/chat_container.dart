import 'package:chateo/main.dart';
import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';

class ChatContainer extends StatelessWidget {
  const ChatContainer({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: mq.width * .04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(left: mq.width * .04),
                child: Container(
                  margin: EdgeInsets.only(
                    top: mq.width * .04,
                  ),
                  padding: EdgeInsets.all(
                    mq.width * .04,
                  ),
                  decoration: const BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //       blurRadius: 3,
                      //       color: Appcolors.blackColor.withOpacity(0.14))
                      // ],
                      color: AppColors.chatcontainerColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )),
                  child: const Text(
                    "Yeah, I am...but I am a bit nervous about meeting everyone",
                    style: TextStyle(
                        fontFamily: 'mulish',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '01:00 pm',
                style: TextStyle(
                    fontFamily: 'hind',
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                    color: AppColors.chattimeColor),
              ),

              // recive message
              Padding(
                padding: EdgeInsets.only(
                  left: mq.width * .04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: mq.width * .4),
                      child: Container(
                        margin: EdgeInsets.only(
                          top: mq.width * .04,
                        ),
                        padding: EdgeInsets.all(
                          mq.width * .04,
                        ),
                        decoration: const BoxDecoration(
                            // boxShadow: [
                            //   BoxShadow(
                            //       blurRadius: 3,
                            //       color: Appcolors.blackColor.withOpacity(0.14))
                            // ],
                            color: AppColors.reciveContainer,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: const Text(
                          "Yeah, I am...but I am a bit nervous about meeting everyone",
                          // message.msg,
                          style: TextStyle(
                              fontFamily: 'mulish',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '01:00 pm',
                      style: TextStyle(
                          fontFamily: 'hind',
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: AppColors.chattimeColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
