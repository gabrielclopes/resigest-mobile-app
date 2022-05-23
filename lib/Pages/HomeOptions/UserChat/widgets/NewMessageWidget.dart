import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Firebase/AuthenticationService.dart';
import 'package:hsc_app_flutter/Pages/Utilities/Decoration.dart';

import '../../../Firebase/DataBaseService.dart';
import '../../../Firebase/FirebaseApi.dart';

class NewMessageWidget extends StatefulWidget {
  final String chatPath;

  const NewMessageWidget({
    required this.chatPath,
    Key? key}) : super(key: key);


  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final TextEditingController _controller = new TextEditingController();
  String message = '';



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0),
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(25))),
              onChanged: (value) => setState(() {
                message = value;
              }),
            ),
          ),
          SizedBox(width: 20),
          GestureDetector(
            onTap: message.trim().isEmpty ? null : sendMessage,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Icon(Icons.send, color: DecorationClass.whiteColor, size: 30,),
            ),
          )
        ],
      ),
    );
  }



  void sendMessage() async{
    FocusScope.of(context).unfocus();

    String myId = AuthenticationService.getUserID();
    String urlPic = await DataBaseService.retrieveUserPic(myId);
    dynamic userData = await DataBaseService.getUserData();

    // FirebaseApi.getChatPath(myId, widget.user.idUser).then((value) => print("xxx" + value));

    await FirebaseApi.uploadMessage(widget.chatPath, message, myId, urlPic, userData[0]);
    _controller.clear();
  }


}
