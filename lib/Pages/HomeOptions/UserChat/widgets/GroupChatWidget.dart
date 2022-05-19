import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/UserChat/UserGroup.dart';


class GroupChatWidget extends StatelessWidget {
  GroupChatWidget({Key? key}) : super(key: key);

  final Color circleColor = Colors.blue.shade200;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          backgroundColor: circleColor,
          radius: 30,
          child: IconButton(
            icon: Icon(Icons.group_outlined),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GroupPage(groupId: "group1",groupName: "Geral"),
              ));
            },
          ),
        ),
        CircleAvatar(
          backgroundColor: circleColor,
          radius: 30,
          child: IconButton(
            icon: Icon(Icons.personal_injury_outlined),
            onPressed: (){

            },
          ),
        ),
        CircleAvatar(
          backgroundColor: circleColor,
          radius: 30,
          child: IconButton(
            icon: Icon(Icons.health_and_safety_outlined),
            onPressed: (){

            },
          ),
        )
      ],
    );
  }
}

