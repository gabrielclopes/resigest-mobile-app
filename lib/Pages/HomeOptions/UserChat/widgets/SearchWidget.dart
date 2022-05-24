import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Utilities/MyButtons.dart';

import '../../../../Constants/Constants.dart';
import '../../../../Model/User.dart';
import '../../../Firebase/DataBaseService.dart';
import '../../../Firebase/FirebaseApi.dart';
import '../UserChat.dart';


class SearchWidget extends StatefulWidget {
  final List<User> users;

  const SearchWidget({
    required this.users,
    Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = new TextEditingController();
  late List<User> queryUser;


  @override
  void initState() {
    queryUser = widget.users;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: MainButton(text: 'Pesquisar',onPressed:(){ contactListDialog(context); } , icon: Icons.search_outlined,)
    );
  }

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
                  onChanged: (val) {
                    updateChats(val);
                  },
                  controller: _controller,
                ),
                flex: 5,
              ),
            ],
          ),
          content: buildChats(context),
          actions: [
            TextButton(
              child: Text("Voltar"),
              onPressed: () => Navigator.pop(context),
            )
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
        itemCount: queryUser.length,
        cacheExtent: 30,
        itemBuilder: (context, index) {
          final User user = queryUser[index];
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 80,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: outlineColor, width: 2)
              ),
              child: ListTile(
                onTap: ()async{
                  Navigator.pop(context);
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



  void updateChats(String value) async {
    setState(() {
      this.queryUser = widget.users.where((user) {
        String name = user.name.toUpperCase();
        return name.contains(value.toUpperCase()) ? true : false;
      }).toList();
    });
  }
}
