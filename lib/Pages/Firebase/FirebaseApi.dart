import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hsc_app_flutter/Constants/Constants.dart';
import 'package:hsc_app_flutter/Model/Message.dart';
import 'package:hsc_app_flutter/Model/User.dart';
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

  static Stream<List<Message>> getMessages(String idUser) =>
      DataBaseService.fStore
      .collection("${DataBaseService.chatCollection}/$idUser/messages")
      .where("idUser",isEqualTo: myId)
      .orderBy(MessageField.createdAt, descending: true)
      .snapshots()
      .transform(Utils.transformer(Message.fromJson));



  // static void getMessages2(String idUser) {
  //   Stream<QuerySnapshot> refSender = DataBaseService.fStore
  //       .collection("${DataBaseService.chatCollection}/$idUser/messages")
  //       .where("idUser",isEqualTo: myId)
  //       .orderBy(MessageField.createdAt, descending: true)
  //       .snapshots();
  //
  //   Stream<QuerySnapshot> refReceiver = DataBaseService.fStore
  //       .collection("${DataBaseService.chatCollection}/$myId/messages")
  //       .where("idUser",isEqualTo: idUser)
  //       .orderBy(MessageField.createdAt, descending: true)
  //       .snapshots();
  //
  //   List<Stream<QuerySnapshot>> combineList = [refSender, refReceiver];
  //
  //   // var newStream = Rx.combineLatest2(
  //   //   refSender, refReceiver,
  //   //     (List<Message>, List<Message>, )
  //   // )
  //   print("ok");
  //   Rx.combineLatest(combineList, (values) => print("+++++ " + values.toString()));
  //   // return
  // }

}