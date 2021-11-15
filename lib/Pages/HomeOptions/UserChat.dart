import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Utilities/Decoration.dart';

import '../HomePage.dart';


class UserChat extends StatelessWidget {
  const UserChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DecorationClass().appBar("Chat"),
      body: Column(
        children: [
          TextButton(onPressed: () {

            // print(HomePage.user.getNome());

            }, child: Text("TESTE"))
        ],
      ),
    );
  }
}
