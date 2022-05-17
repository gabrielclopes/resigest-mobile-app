import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hsc_app_flutter/Model/Message.dart';
import 'package:hsc_app_flutter/Model/User.dart';
import 'package:hsc_app_flutter/Pages/Firebase/DataBaseService.dart';
import 'package:hsc_app_flutter/Pages/Utilities/Utils.dart';



class FirebaseApi{
  static Stream<List<User>> getUsers() => FirebaseFirestore.instance
      .collection(DataBaseService.userCollection)
      .snapshots()
      .transform(Utils.transformer(User.fromJson));



  static Future uploadMessage(String chatPath, String message, String myId, String urlPic, String myName) async {
    // String chatPath = await FirebaseApi.getChatPath(myId, id);
    final refMessages = DataBaseService.fStore.collection(chatPath);

    final newMessage = Message(
        idUser: myId,
        urlAvatar: urlPic,
        username: myName,
        message: message,
        createdAt: DateTime.now()
    );
    await refMessages.add(newMessage.toJson());

    // final refUsers = DataBaseService.fStore.collection(DataBaseService.userCollection);
    // await refUsers.doc(id).update({UserField.lastMessageTime: DateTime.now()});
  }

  static Future<String> getChatPath(String myId, String userId) async {
    final refChat = DataBaseService.fStore.collection("${DataBaseService.chatCollection}");
    String usersChatField = "users";

    var x = await refChat.where(usersChatField, arrayContains: myId).get();
    bool chatExists = false;
    String docId = "";

    x.docs.forEach((document) {
      List<dynamic> arr = document.get(usersChatField);
      if(arr.contains(userId)){
        chatExists = true;
        docId = document.id;
      }
    });
    if (!chatExists){
      DocumentReference doc = await refChat.add({
        usersChatField: [myId, userId]
      });
      docId = doc.id;
    }
    return "${DataBaseService.chatCollection}/$docId/messages";
  }


  static Stream<List<Message>> getMessages(String chatPath) =>
      DataBaseService.fStore
      .collection(chatPath)
      .orderBy(MessageField.createdAt, descending: true)
      .snapshots()
      .transform(Utils.transformer(Message.fromJson));



  // static void retrieveMessages(String idUser) {
  //
  // }

}