import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Stream<QuerySnapshot> getChats(String userId){
    return _firestore
        .collection("chats")
        .where('user',arrayContains: userId)
        .snapshots();
  }

  Stream<QuerySnapshot> searchUsers(String query){
    return _firestore
        .collection("users")
        .where('email',isGreaterThanOrEqualTo: query)
        .where('email',isLessThanOrEqualTo: query + '\uf8ff')
        .snapshots();
  }

  Future<void> sendMessage(String chatId,String message,String receiverId,) async{
    final currentUser=_auth.currentUser;
    if(currentUser!=null){
      await _firestore.collection('chats').doc(chatId).collection('messages').add({
        'senderId': currentUser.uid,
        'receiverId':receiverId,
        'messageBody':message,
        'timeStamp':FieldValue.serverTimestamp()
      });
    }
}
}