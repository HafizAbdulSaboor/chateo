import 'package:flutter/material.dart';

Widget callsAvatar(String imgUrl){
  return Container(
    width: 70,
    height: 70,
    decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        shape: BoxShape.circle),
    child: ClipOval(
        child: Image.asset(imgUrl,fit: BoxFit.cover,)
    ),
  );
}