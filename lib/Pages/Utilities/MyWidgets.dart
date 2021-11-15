import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Firebase/AuthenticationService.dart';
import 'package:hsc_app_flutter/Pages/Firebase/DataBaseService.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/ProfilePage.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';


class UserProfile extends StatefulWidget {

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String nome = "---";
  String email = "---";
  Widget? _image;
  File? _avatarIcon;
  bool hasImage = false;

  @override
  void initState() {
    _image = CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue), strokeWidth: 7, );
    setUpUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Container(
        child: Row(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  child: CircleAvatar(
                    radius: 50, backgroundColor: Colors.grey[300],
                    child: ClipOval(
                      child: SizedBox(
                          width: 90,
                          height: 90,
                          child: _image
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 15,),
            generateUserInfo(),

          ],
        ),
      ),
    );
  }


  Widget generateUserInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NOME
                Align(alignment: Alignment.centerLeft,
                  child: Text(nome, style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[800])),),
                SizedBox(height: 10,),
                // EMAIL
                Align(alignment: Alignment.centerLeft,
                  child: Text(email, style:
                  TextStyle(fontWeight: FontWeight.normal, fontSize: 17,), textAlign: TextAlign.start,),),
              ],
            ),
          ),
        )
      ],
    );
  }


  setUpUserInfo() async {
    dynamic userData = await DataBaseService().getUserData();

    if (userData != null) {
      String nome = userData[0];
      String email = userData[1];
      setState(() {
        this.nome = nome;
        this.email = email;
      });
    }
    else {
      print("User information not found");
    }
    await loadImage();


  }


  Future loadImage() async{
    DataBaseService().retrieveUserPic().then((value) {
      if(value != "nao"){
        setState(() {
          _image = Image.network(value.toString(), fit: BoxFit.cover,);
        });
      }
      else{
        setState(() {
          _image = Image.asset("assets/images/avatar.jpg", fit: BoxFit.fill,);
        });
      }
    });

  }



}

