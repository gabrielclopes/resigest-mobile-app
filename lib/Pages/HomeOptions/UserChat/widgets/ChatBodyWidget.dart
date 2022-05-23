
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Firebase/FirebaseApi.dart';
import 'package:hsc_app_flutter/Pages/Utilities/Decoration.dart';

import '../../../../Constants/Constants.dart';
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
      child: buildRecentChats(),
    );
  }


  Widget buildRecentChats() => StreamBuilder<QuerySnapshot>(
    stream: FirebaseApi.getChats(myId),
    builder: (context, snapshot) {
      switch (snapshot.connectionState){
        case ConnectionState.waiting:
          return Center(child: Row(children: [
            Skeleton(height: 40,width: 40, defaultPadding: 30,),
            SizedBox(width: 10,),
            Skeleton(height: 40,width: 200,)
          ],));
      // DATA ended loading
        default:
          if(snapshot.hasError || !snapshot.hasData){
            return Text("Erro " + snapshot.error.toString());
          }
          else{
            final chats = snapshot.data;
            if(chats == null || chats.size == 0){
              return Text("Nenhuma Conversa Recente");
            }
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: chats.docs.length,
              cacheExtent: 30,
              itemBuilder: (BuildContext context, int index) {
                var chat = chats.docs[index];
                List users = chat.get("users");
                int userIndex = users.indexOf(myId);
                User recieverUser = ((userIndex == 0) ?
                this.users.where((user) => user.idUser == users[1]).single
                :this.users.where((user) => user.idUser == users[0]).single);

                return userTile(recieverUser, context, "15:33");

              },
            );
          }

      }
    },

  );





  Widget userTile(User user, BuildContext context, String time) {
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
          onTap: ()async{
            String chatPath = await FirebaseApi.getChatPath(myId, user.idUser);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatPage(user: user, chatPath: chatPath),
            ));
          },
          leading: FutureBuilder(
            future: DataBaseService.retrieveUserPic(user.idUser),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return  Skeleton(width: 50);
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
          trailing: Text(time),
        ),
      ),
    );
  }



  // Widget buildChats() => ListView.builder(
  //   physics: BouncingScrollPhysics(),
  //   itemCount: users.length,
  //   cacheExtent: 30,
  //   itemBuilder: (context, index) {
  //     final User user = users[index];
  //     return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //         height: 80,
  //         padding: EdgeInsets.all(8),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(30),
  //             border: Border.all(color: outlineColor, width: 2)
  //         ),
  //         child: ListTile(
  //           onTap: ()async{
  //             String chatPath = await FirebaseApi.getChatPath(myId, user.idUser);
  //             Navigator.of(context).push(MaterialPageRoute(
  //               builder: (context) => ChatPage(user: user, chatPath: chatPath),
  //             ));
  //           },
  //           leading: FutureBuilder(
  //             future: DataBaseService.retrieveUserPic(user.idUser),
  //             builder: (context, snapshot){
  //               if(!snapshot.hasData){
  //                 return CircularProgressIndicator();
  //               }
  //               else{
  //                 if(snapshot.data.toString() == "nao"){
  //                   return Icon(Icons.person, size: 50,);
  //                 }
  //                 else{
  //                   return CircleAvatar(
  //                     radius: 28,
  //                     backgroundColor: (user.residenceType == 'medica') ? Colors.blueAccent : Colors.greenAccent[700],
  //                     child: CircleAvatar(
  //                       radius: 25,
  //                       backgroundImage: NetworkImage(snapshot.data.toString()),
  //                     ),
  //                   );
  //                 }
  //               }
  //             },
  //           ),
  //           title: Row(children: [
  //             VerticalDivider(color: Colors.grey, thickness: 1.4),
  //             Text(user.name, style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold))
  //           ],),
  //         ),
  //       ),
  //     );
  //   },
  // );


}


