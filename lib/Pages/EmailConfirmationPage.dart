import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Firebase/AuthenticationService.dart';
import 'package:hsc_app_flutter/Pages/LoginPage.dart';

import 'HomePage.dart';
import 'Utilities/Decoration.dart';


class EmailConfirmationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AuthenticationService().sendEmailVerification();
    return Scaffold(
      appBar: DecorationClass().appBar("CADASTRO"),
      body: Container(
        height: double.infinity,
        width: double.infinity,

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Confirmação\n de e-mail", style:
              TextStyle(
                  fontSize: 34,
                  color: LoginButtonDesign.colorSec,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
              SizedBox(height: 10),
              Text("Acesse seu e-mail e confira o link\n de confirmação de conta",
              style: TextStyle(
                fontSize: 17
              ),textAlign: TextAlign.center,),
              SizedBox(height: 10),
              Container(
                width: 90,
                height: 50,
                child: Icon(Icons.mark_email_unread_outlined, color: Colors.white, size: 40,),

                decoration: DecorationClass().boxDecoration(),),
              SizedBox(height: 15),
              buildConfirmationButton(context),
            ],
          ),
        ),
      ),
    );
  }




  Widget buildConfirmationButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pushReplacementNamed("/login"),
      style: ElevatedButton.styleFrom(
          shadowColor: Colors.black,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [LoginButtonDesign.colorPri, LoginButtonDesign.colorSec],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Container(
          width: 280,
          height: 45,
          alignment: Alignment.center,
          child: Text("Continuar", style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
