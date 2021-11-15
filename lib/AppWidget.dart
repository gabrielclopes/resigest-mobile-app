import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/EmailConfirmationPage.dart';
import 'package:hsc_app_flutter/Pages/Firebase/AuthenticationService.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/ProfilePage.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/Record/ConfirmRecord.dart';
import 'package:hsc_app_flutter/Pages/LoginPage.dart';
import 'package:hsc_app_flutter/Pages/RegisterPage.dart';
import 'package:hsc_app_flutter/appController.dart';
import 'Pages/HomeOptions/Record/DailyRecord.dart';
import 'Pages/HomeOptions/UserChat.dart';
import 'Pages/HomePage.dart';




class AppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ResiGest",
      theme: ThemeData(
          brightness: AppController.instance.isDartTheme ? Brightness.dark : Brightness.light
      ),
      home: AuthenticationWrapper(),
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/email_conf': (context) => EmailConfirmationPage(),
        '/daily_rec': (context) => DailyRecord(),
        '/chat': (context) => UserChat(),
        '/profile': (context) => ProfilePage(),
        '/conf_record': (context) => ConfirmRecord(),
      },
    );

  }
}

class AuthenticationWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    if(AuthenticationService().isSignedIn())
      return HomePage();
    else
      return LoginPage();


  }



}
