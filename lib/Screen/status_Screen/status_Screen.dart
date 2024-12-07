import 'package:chateo/utils/colors.dart';
import 'package:chateo/widgets/stories_avatar.dart';
import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache images here
    for (String imagePath in imgUrls) {
      precacheImage(AssetImage(imagePath), context);
    }
  }
  List<String> imgUrls = [
    'assets/image/story1.jpg',
    'assets/image/story2.jpg',
    'assets/image/story3.jpg',
    'assets/image/story4.jpg',
    'assets/image/story5.jpg',
  ];
  List<String> name = ['Hassan', 'Ali', 'Sana', 'Hamza', 'Faiz'];
  List<String> time = [
    '1:49 pm',
    '12:36 pm',
    '11:00 am',
    '9:59 am',
    '7:32 am'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        primary: true,
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text('Stories',
              style: TextStyle(
                  fontFamily: 'mulish',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor)),
        ),
        actions: const [
          Icon(
            Icons.search,
            color: AppColors.blackColor,
          ),
          SizedBox(
            width: 15,
          ),
          Padding(
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
                          width: 78,
                          height: 78,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.green,
                                Colors.blue,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              shape: BoxShape.circle),
                          child: ClipOval(
                              child: Image.asset(
                            'assets/image/mystory.jpg',
                            fit: BoxFit.cover,
                          )),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.backgroundColor,
                                  ),
                                ),
                                Container(
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
                                ),
                              ],
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
                        Text('My Story',
                            style: TextStyle(
                                fontFamily: 'mulish',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blackColor)),
                        Text('Tap to add a story',
                            style: TextStyle(
                                fontFamily: 'mulish',
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppColors.textColor)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text('New Updates',
                  style: TextStyle(
                      fontFamily: 'mulish',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor)),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: imgUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        child: Row(
                          children: [
                            storiesAvatar(imgUrls[index]),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(name[index],
                                    style: const TextStyle(
                                        fontFamily: 'mulish',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.blackColor)),
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
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                height: 150,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize
            .min, // Ensures the column takes only the necessary space
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColors.floatingcontainerColor),
            child: const Center(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          const SizedBox(height: 16), // Space between the two FABs
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color(0xff5BF4CF)),
            child: const Center(
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
