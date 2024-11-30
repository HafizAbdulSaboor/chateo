import 'package:flutter/material.dart';

Widget storiesAvatar(String imgUrl){
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 78,
        height: 78,
        decoration: BoxDecoration(
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
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            shape: BoxShape.circle),
        child: ClipOval(
            child: Image.asset(imgUrl,fit: BoxFit.cover,)
        ),
      ),
    ],
  );
}