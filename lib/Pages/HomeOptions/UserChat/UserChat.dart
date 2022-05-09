import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/UserChat/widgets/MessagesWidget.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/UserChat/widgets/NewMessageWidget.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/UserChat/widgets/ProfileHeaderWidget.dart';

import '../../../Model/User.dart';


class ChatPage extends StatefulWidget {
  final User user;


  const ChatPage({
    required this.user,
    Key? key }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Colors.blueAccent,
    body: SafeArea(
      child: Column(
        children: [
          ProfileHeaderWidget(name: widget.user.name),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: MessagesWidget(idUser: widget.user.idUser),
            ),
          ),
          NewMessageWidget(idUser: widget.user.idUser)
        ],
      ),
    ),
  );
}














