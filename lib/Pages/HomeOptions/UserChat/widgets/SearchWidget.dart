import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Utilities/MyButtons.dart';

import '../../../../Constants/Constants.dart';
import '../../../../Model/User.dart';
import '../../../Firebase/DataBaseService.dart';
import '../../../Firebase/FirebaseApi.dart';
import '../UserChat.dart';


class SearchWidget extends StatelessWidget {
  final List<User> users;

  const SearchWidget({
    required this.users,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: MainButton(text: 'Pesquisar',onPressed:(){ contactListDialog(context); } , icon: Icons.search_outlined,)
    );
  }
  // ElevatedButton(
  //
  // onPressed: () => contactListDialog(context),
  // child: Row(
  // mainAxisAlignment: MainAxisAlignment.center,
  // children: [
  // Icon(Icons.search_outlined),
  // Text("Pesquisar"),
  // ],
  // ),
  //
  // ),




  Future contactListDialog (BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Expanded(
                child:
                    Icon(Icons.search_outlined, size: 30, color: Colors.black),
              ),
              Expanded(
                child: TextField(

                ),
                flex: 5,
              ),
            ],
          ),
          content: buildChats(context),
          actions: [
            Text("cancel")
          ],



        );
      },
    );

  }


  Widget buildChats(BuildContext context) {
    Color outlineColor = Colors.lightBlueAccent;

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 1,
      child: ListView.builder(
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
                  Flexible(child: Text(user.name, style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)))
                ],),
              ),
            ),
          );
        },
      ),
    );

  }


}
