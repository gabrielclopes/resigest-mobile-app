import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Firebase/DataBaseService.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/UserChat/widgets/MessagesWidget.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/UserChat/widgets/NewMessageWidget.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/UserChat/widgets/ProfileHeaderWidget.dart';



class GroupPage extends StatelessWidget {

  final String groupId;
  final String groupName;


  const GroupPage({
    required this.groupName,
    required this.groupId,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Colors.blueAccent,
    body: SafeArea(
      child: Column(
        children: [
          ProfileHeaderWidget(name: this.groupName),
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
              child: MessagesWidget(chatPath: getGroupPath()),
            ),
          ),
          NewMessageWidget(chatPath: getGroupPath())
        ],
      ),
    ),
  );



  String getGroupPath(){
    return DataBaseService.chatCollection +"/"+ groupId +"/"+ "messages";
  }
}
