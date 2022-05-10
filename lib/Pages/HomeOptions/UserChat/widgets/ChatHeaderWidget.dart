import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Constants/Constants.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width *75,
            child: Center(child: Text("Em desenvolvimento...")),
          )

        ],

      ),
    );
  }
}
