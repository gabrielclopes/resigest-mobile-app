import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/UserChat/widgets/GroupChatWidget.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/UserChat/widgets/SearchWidget.dart';

import '../../../../Model/User.dart';



class ChatHeaderWidget extends StatelessWidget {
  final List<User> users;

  const ChatHeaderWidget({
    required this.users,
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SearchWidget(users: users),
          GroupChatWidget(),
        ],

      ),
    );
  }
}
