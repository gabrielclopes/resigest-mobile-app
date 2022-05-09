
import 'package:flutter/material.dart';

import '../../../../Constants/Constants.dart';
import '../../../../Model/Message.dart';
import '../../../Firebase/FirebaseApi.dart';
import 'MessageWidget.dart';


class MessagesWidget extends StatelessWidget {
  final String idUser;

  const MessagesWidget({
    required this.idUser,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(

        stream: FirebaseApi.getMessages(idUser),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data;
                if(messages != null){
                  return messages.isEmpty
                      ? buildText('Comece a conversa! ..')
                      : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return MessageWidget(
                        message: message,
                        isMe: message.idUser == myId,
                      );
                    },
                  );
                } else {return Text("");}

              }
          }
        },
      );

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24),
    ),
  );
}