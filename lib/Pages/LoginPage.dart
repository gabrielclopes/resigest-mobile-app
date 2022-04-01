import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hsc_app_flutter/Pages/Firebase/AuthenticationService.dart';
import 'package:hsc_app_flutter/Pages/HomePage.dart';

import 'Utilities/Decoration.dart';
import 'Utilities/MyButtons.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(child: Image.asset("assets/images/HSC_logo.png"), width: 120,),
              SizedBox(height: 70),
              buildEmailField(),
              SizedBox(height: 20),
              buildPasswordField(),
              SizedBox(height: 30),
              MainButton(
                  text: "Acessar",
                  onPressed:  () async {
                    if(await AuthenticationService().signIn(email: emailController.text, password: passwordController.text)) {
                      if(await AuthenticationService().emailIsVerified()){
                        Fluttertoast.showToast(msg: "Conectado com sucesso", backgroundColor: Colors.grey);
                        Navigator.of(context).pushReplacementNamed("/home");
                      }
                      else{
                        Fluttertoast.showToast(msg: "Email não verificado!", backgroundColor: Colors.grey);
                      }
                    }
                  }),
              SizedBox(height: 10),
              MoveToRegisterWidget(),
            ],
          ),
        ),
      ),
    );
  }


  TextField buildEmailField() {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Email"),
    );
  }

  TextField buildPasswordField() {
    return TextField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Senha"),
    );
  }
}





class LoginButtonDesign extends StatelessWidget {
  static final Color colorPri = Color(0xFF01A6E8); //azul claro
  static final Color colorSec = Color(0xFF014891); //azul escuro

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorPri, colorSec],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30)),
      child: Container(
        width: 250,
        height: 50,
        alignment: Alignment.center,
        child: Text("Acessar", style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}



class MoveToRegisterWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {Navigator.of(context).pushNamed("/resi_selector");},
        child: Text("Clique aqui para registrar uma nova conta"),
      ),
    );
  }
}

