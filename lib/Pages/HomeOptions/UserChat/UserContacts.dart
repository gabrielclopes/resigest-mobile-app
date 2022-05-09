import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Firebase/FirebaseApi.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/UserChat/widgets/ChatBodyWidget.dart';
import 'package:hsc_app_flutter/Pages/Utilities/Decoration.dart';

import '../../../Model/User.dart';
import 'widgets/ChatHeaderWidget.dart';



class UserChat extends StatelessWidget {
  const UserChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],     //test color

      appBar: DecorationClass().appBar("Chat"),
      body: SafeArea(
        child: StreamBuilder<List<User>>(
          stream: FirebaseApi.getUsers(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              // DATA ended loading
              default:
                if(snapshot.hasError){
                  return Text("Erro " + snapshot.error.toString());
                }
                else{
                  final users = snapshot.data;
                  if(users == null || users.isEmpty){
                    return Text("Nenhum usuário encontrado");
                  }
                  return Column(
                    children: [
                      Expanded(child: ChatHeaderWidget(users: users,)),
                      Expanded(child: ChatBodyWidget(users: users,), flex: 5),
                    ],
                  );
                }

            }
          }
          ),

        ),
    );
  }
}
