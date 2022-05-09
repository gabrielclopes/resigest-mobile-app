import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Constants/Constants.dart';
import 'package:hsc_app_flutter/Pages/EmailConfirmationPage.dart';
import 'package:hsc_app_flutter/Pages/Firebase/AuthenticationService.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/ProfilePage.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/Record/ConfirmRecord.dart';
import 'package:hsc_app_flutter/Pages/LoginPage.dart';
import 'package:hsc_app_flutter/Pages/Register/MedicaSelector.dart';
import 'package:hsc_app_flutter/Pages/Register/MultiSelector.dart';
import 'package:hsc_app_flutter/Pages/Register/RegisterPage.dart';
import 'package:hsc_app_flutter/Pages/Register/ResidenceSelector.dart';
import 'package:hsc_app_flutter/appController.dart';
import 'Pages/HomeOptions/Record/DailyRecord.dart';
import 'Pages/HomeOptions/UserChat/UserContacts.dart';
import 'Pages/HomePage.dart';




class AppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ResiGest",
      theme: ThemeData(
          brightness: AppController.instance.isDartTheme ? Brightness.dark : Brightness.light
      ),
      home: AuthenticationWrapper(),
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/email_conf': (context) => EmailConfirmationPage(),
        '/daily_rec': (context) => DailyRecord(),
        '/chat': (context) => UserChat(),
        '/profile': (context) => ProfilePage(),
        '/conf_record': (context) => ConfirmRecord(),
        '/resi_selector': (context) => ResidenceSelector(),
        '/resi_med': (context) => MedicaSelector(),
        '/resi_multi': (context) => MultiSelector(),

      },
    );

  }
}

class AuthenticationWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    if(AuthenticationService().isSignedIn()){
      retrieveId();
      return HomePage();
    }
    else
      return LoginPage();

  }

  void retrieveId(){
    myId = AuthenticationService.getUserID();
  }
}



