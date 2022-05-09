import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hsc_app_flutter/Model/Message.dart';
import 'package:hsc_app_flutter/Model/User.dart';
import 'package:hsc_app_flutter/Pages/Firebase/AuthenticationService.dart';
import 'package:hsc_app_flutter/Pages/Firebase/DataBaseService.dart';
import 'package:hsc_app_flutter/Pages/Utilities/Utils.dart';



class FirebaseApi{
  static Stream<List<User>> getUsers() => FirebaseFirestore.instance
      .collection(DataBaseService.userCollection)
      .snapshots()
      .transform(Utils.transformer(User.fromJson));



  static Future uploadMessage(String id, String message, String myId, String urlPic, String myName) async {
    final refMessages = DataBaseService.fStore.collection("${DataBaseService.chatCollection}/$id/messages");

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

}