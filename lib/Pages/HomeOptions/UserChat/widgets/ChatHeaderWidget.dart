import 'package:flutter/material.dart';

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
        children: [
          Container(
            width: MediaQuery.of(context).size.width *75,
            child: Text("teste123"),

          )

        ],

      ),
    );
  }
}
