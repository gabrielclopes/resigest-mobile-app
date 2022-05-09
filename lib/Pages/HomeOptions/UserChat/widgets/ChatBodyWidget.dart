

import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Utilities/Decoration.dart';

import '../../../../Model/User.dart';
import '../../../Firebase/DataBaseService.dart';
import '../UserChat.dart';





class ChatBodyWidget extends StatelessWidget {
  final List<User> users;
  final Color outlineColor = Colors.lightBlueAccent;

  const ChatBodyWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: DecorationClass.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )
      ),
      child: buildChats(),
    );
  }





  Widget buildChats() => ListView.builder(
    physics: BouncingScrollPhysics(),
    itemCount: users.length,
    cacheExtent: 30,
    itemBuilder: (context, index) {
      final User user = users[index];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 80,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: outlineColor, width: 2)
          ),
          child: ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatPage(user: user),
              ));
            },
            leading: FutureBuilder(
              future: DataBaseService.retrieveUserPic(user.idUser),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }
                else{
                  if(snapshot.data.toString() == "nao"){
                    return Icon(Icons.person, size: 50,);
                  }
                  else{
                    return CircleAvatar(
                      radius: 28,
                      backgroundColor: (user.residenceType == 'medica') ? Colors.blueAccent : Colors.greenAccent[700],
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(snapshot.data.toString()),
                      ),
                    );
                  }
                }
              },
            ),
            title: Row(children: [
              VerticalDivider(color: Colors.grey, thickness: 1.4),
              Text(user.name, style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold))
            ],),
          ),
        ),
      );
    },
  );


}


