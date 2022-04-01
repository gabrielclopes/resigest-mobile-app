import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hsc_app_flutter/Pages/Firebase/DataBaseService.dart';
import 'package:hsc_app_flutter/Pages/LoginPage.dart';
import 'package:hsc_app_flutter/Pages/Utilities/MyButtons.dart';

import 'Firebase/AuthenticationService.dart';
import 'HomePage.dart';
import 'Utilities/Decoration.dart';

class RegisterPage extends StatefulWidget {
  final String residenceType;
  final String residenceField;

  RegisterPage(this.residenceType, this.residenceField);



  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DecorationClass().appBar("CADASTRO"),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(child: Image.asset("assets/images/HSC_logo.png"), width: 120,),
                SizedBox(height: 50),
                Fields(title: 'Nome completo', controller: nameController),
                SizedBox(height: 20),
                Fields(title: 'Email', controller: emailController, isEmail: true),
                SizedBox(height: 20),
                Fields(title: 'Senha', controller: passwordController, obscureText: true),
                SizedBox(height: 30),
                Fields(title: 'Repetir Senha', controller: repeatPasswordController, obscureText: true),
                SizedBox(height: 30),
                MainButton(text: "Registrar",
                onPressed:  () async {
                  if(verifyEmailAndPass())
                    if(await AuthenticationService().signUp(email: emailController.text, password: passwordController.text)) {
                      Fluttertoast.showToast(msg: "Registrado com sucesso", backgroundColor: Colors.grey);
                      DataBaseService().addUserDocument(nameController.text, emailController.text, widget.residenceField, widget.residenceType);
                      Navigator.of(context).pushReplacementNamed("/email_conf");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }


  bool verifyEmailAndPass() {

    if (emailController.text.isEmpty){
      Fluttertoast.showToast(msg: "Email está vazio", backgroundColor: Colors.grey);
      return false;
    }
    else if (!emailController.text.contains("@")){
      Fluttertoast.showToast(msg: "Não é um email institucional válido", backgroundColor: Colors.grey);
      return false;
    }
    else if(passwordController.text.length < 6) {
      Fluttertoast.showToast(msg: "Senha muito curta", backgroundColor: Colors.grey);
      return false;
    }
    else if(passwordController.text != repeatPasswordController.text) {
      Fluttertoast.showToast(msg: "Senhas não coincidem", backgroundColor: Colors.grey);
      return false;
    }
    else
      return true;
  }

}




class MoveToRegisterWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {Navigator.of(context).pushNamed("/register");},
        child: Text("Clique aqui para registrar uma nova conta."),
      ),
    );
  }
}



class Fields extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool obscureText;
  final bool isEmail;

  const Fields({
    Key? key,
    required this.title,
    required this.controller,
    this.obscureText = false,
    this.isEmail = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: isEmail ? TextInputType.emailAddress: TextInputType.name,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: title),
    );
  }
}
