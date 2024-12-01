// import 'package:chateo/utils/colors.dart';
// import 'package:flutter/material.dart';

// class GroupScreen extends StatelessWidget {
//   const GroupScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<String> title = [
//       'Accounts',
//       'Privacy',
//       'Chats',
//       'Notifications',
//       'Data and Storage',
//       'Language'
//     ];
//     List<String> subTitle = [
//       'Number, email, security',
//       'Block contacts, message encryption',
//       'Wallpapers, chat history, archived',
//       'Call tones, messages, group chats',
//       'Backup, network usage',
//       'English (device language)'
//     ];
//     List<Icon> icons = [
//       const Icon(Icons.key),
//       const Icon(Icons.lock),
//       const Icon(Icons.chat),
//       const Icon(Icons.notifications),
//       const Icon(Icons.cloud),
//       const Icon(Icons.public)
//     ];

//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           elevation: 0,
//           scrolledUnderElevation: 0,
//           primary: true,
//           backgroundColor: Colors.white,
//           leading: const Icon(Icons.arrow_back, color: Colors.black),
//           title: const Text('Settings',
//               style: TextStyle(
//                   fontFamily: 'mulish',
//                   fontSize: 30,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.blackColor)),
//           actions: const [
//             Icon(
//               Icons.search,
//               color: AppColors.blackColor,
//             ),
//             SizedBox(
//               width: 15,
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 19.0),
//               child: Icon(Icons.more_vert, color: AppColors.blackColor),
//             )
//           ],
//         ),
//         body: SingleChildScrollView(
//           // Make the content scrollable
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 18.0),
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Container(
//                       width: 80,
//                       height: 80,
//                       decoration: const BoxDecoration(shape: BoxShape.circle),
//                       child: ClipOval(
//                         child: Image.asset('assets/image/story4.jpg',
//                             fit: BoxFit.cover),
//                       ),
//                     ),
//                     Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Container(
//                           width: 25,
//                           height: 25,
//                           decoration: const BoxDecoration(
//                             color: Colors.black,
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Center(
//                             child: Icon(
//                               Icons.camera_alt,
//                               size: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text('Hassaan',
//                   style: TextStyle(
//                       fontFamily: 'mulish',
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.blackColor)),
//               const SizedBox(height: 10),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 height: 35,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     color: Colors.blueGrey),
//                 child: const Align(
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 12.0),
//                     child: Text('Do not disturb!',
//                         style: TextStyle(
//                             fontFamily: 'mulish',
//                             fontSize: 12,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white60)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 decoration: const BoxDecoration(
//                   color: AppColors.backgroundColor,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 12.0, vertical: 20),
//                   child: ListView.builder(
//                     shrinkWrap: true, // Allows ListView to wrap its content
//                     physics:
//                         const NeverScrollableScrollPhysics(), // Prevent scrolling
//                     itemCount: title.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         leading: Container(
//                           width: 60,
//                           height: 60,
//                           decoration: const BoxDecoration(
//                               shape: BoxShape.circle, color: Colors.white),
//                           child: icons[index],
//                         ),
//                         title: Text(title[index],
//                             style: const TextStyle(
//                                 fontFamily: 'mulish',
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black)),
//                         subtitle: Text(subTitle[index],
//                             style: const TextStyle(
//                                 fontFamily: 'mulish',
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.blueGrey)),
//                       );
//                     },
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ));
//     // return Scaffold(
//     //   body: Center(
//     //     child: Text('Group Screen'),
//     //   ),
//     // ));
//   }
// }
import 'package:flutter/material.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Group Screen'),
      ),
    );
  }
}
