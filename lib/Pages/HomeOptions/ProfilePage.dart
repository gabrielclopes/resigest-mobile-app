
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Firebase/AuthenticationService.dart';
import 'package:hsc_app_flutter/Pages/Firebase/DataBaseService.dart';
import 'package:hsc_app_flutter/Pages/Utilities/Decoration.dart';
import 'package:image_picker/image_picker.dart';

import '../HomePage.dart';

class ProfilePage extends StatefulWidget {
  static String picFolder = "userPic/";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  String nome = "--";
  String email = "---";
  File? _avatarIcon;
  Image? _image = Image.asset("assets/images/avatar.jpg", fit: BoxFit.fill,);
  bool hasImage = false;
  bool insideHospital = false;

  @override
  void initState() {
    setUpUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DecorationClass().appBar("Perfil"),
      body: Builder(
        builder: (context) => Container(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: CircleAvatar(
                      radius: 50, backgroundColor: Colors.blue,
                      child: ClipOval(
                        child: SizedBox(
                          width: 90,
                          height: 90,
                          child: (_image != null)?SizedBox(child: _image,)
                              :Image.asset("assets/images/avatar.jpg", fit: BoxFit.fill,)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: IconButton(icon: Icon(Icons.edit),onPressed: () => uploadPic(),),)
                ],
              ),
              SizedBox(height: 30,),
              generateUserInfo(),

            ],
          ),
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
              children: [
                // NOME
                Align(alignment: Alignment.centerLeft, child: Text("Nome", style: TextStyle(fontSize: 18),),),
                Align(alignment: Alignment.centerLeft, child: Text(nome, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),
                SizedBox(height: 10,),
                // EMAIL
                Align(alignment: Alignment.centerLeft, child: Text("Email", style: TextStyle(fontSize: 18),),),
                Align(alignment: Alignment.centerLeft, child: Text(email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),
                SizedBox(height: 30,),
                // Está no Hospital
                Align(alignment: Alignment.centerLeft, child: Text(insideHospital ? "Residente está agora no hospital" : "Residente não está no hospital", style: TextStyle(fontSize: 18, color: Colors.blueGrey),),),
              ],
            ),
          ),
        )
      ],
    );
  }


  setUpUserInfo() async {
    dynamic userData = await DataBaseService().getUserData();

    insideHospital = await DataBaseService.isInsideHospital() ? true : false;

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



  Future uploadPic() async{
    await getImage();

    String fileName = ProfilePage.picFolder + AuthenticationService().getUserID() + "_pic";
    Reference firebaseStorageRef = DataBaseService.fStorage.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_avatarIcon as File);
    TaskSnapshot taskSnapshot = await uploadTask;
    await loadImage();
    
  }

  Future getImage() async {

    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _avatarIcon = new File(image!.path);
    });

  }


  Future loadImage() async{
    DataBaseService().retrieveUserPic().then((value) {
      if(value != "nao"){
        setState(() {
          _image = Image.network(value.toString(), fit: BoxFit.cover,);
        });
      }
    });

  }


}


