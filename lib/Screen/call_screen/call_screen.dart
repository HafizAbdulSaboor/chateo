import 'package:chateo/utils/colors.dart';
import 'package:chateo/widgets/stories_avatar.dart';
import 'package:flutter/material.dart';

import '../../widgets/calls_avatar.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List <String>imgUrls=['assets/image/story1.jpg','assets/image/story2.jpg','assets/image/story3.jpg','assets/image/story4.jpg','assets/image/story5.jpg',];
    List <String>name=['Hassaan','Ali','Sana','Hamza','Faiz'];
    List <String>time=['1:49 pm','12:36 pm','11:00 am','9:59 am','7:32 am'];
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        primary: true,
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text('Call Logs',
              style: TextStyle(
                  fontFamily: 'mulish',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor)),
        ),
        actions: [
          const Icon(
            Icons.search,
            color: AppColors.blackColor,
          ),
          const SizedBox(
            width: 15,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 19.0),
            child: Icon(Icons.more_vert, color: AppColors.blackColor),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(23.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle),
                          child: Center(
                            child: Image.asset('assets/icon/calllink.png',fit: BoxFit.cover,width: 25,height: 25,),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Create a call link',
                            style: TextStyle(
                                fontFamily: 'mulish',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blackColor)),
                        Text('Share with your infinite friends',
                            style: TextStyle(
                                fontFamily: 'mulish',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              const Text('Recent',
                  style: TextStyle(
                      fontFamily: 'mulish',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor)),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: imgUrls.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        child: Row(
                          children: [
                            callsAvatar(imgUrls[index]),
                            const SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(name[index],
                                    style: TextStyle(
                                        fontFamily: 'mulish',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      color: index == 0 ? Colors.red : AppColors.blackColor,)),
                                Row(
                                  children: [
                                    Icon(
                                      index == 0 ? Icons.call_received : Icons.call_made,
                                      color: index == 0 ? Colors.red : AppColors.blackColor, size: 18,
                                    ),
                                    const SizedBox(width: 5,),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Today, ', // First text
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: time[index], // Second text
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Icon(
                              index == 0 || index == 1 ? Icons.call : Icons.video_call,
                              color: Colors.black,
                            ),

                          ],
                        ),
                      ),
                    );
                  }),
              SizedBox(height: 150,)
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color(0xff5BF4CF)
            ),
            child: const Center(
              child: Icon(Icons.add_ic_call_outlined,color: Colors.white,size: 25,),
            ),
          ),
          const SizedBox(height: 100,)
        ],
      ),
    );
  }
}
