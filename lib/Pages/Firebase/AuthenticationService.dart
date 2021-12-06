
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AuthenticationService {

  static final fAuth = FirebaseAuth.instance;


  Future<bool> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await fAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return Future<bool>.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password'){
        Fluttertoast.showToast(msg: "Usuário ou senha inválido(s)", backgroundColor: Colors.grey);
      }


      print("Login_error = " + e.code);
      return Future<bool>.value(false);
    }
  }

  Future<bool> signUp({required String email, required String password}) async {
    try {
      UserCredential userCredential = await fAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return Future<bool>.value(true);
    } on FirebaseAuthException catch (e) {
      print("Register_error= " + e.code);
      return Future<bool>.value(false);
    }
  }

  bool isSignedIn() {
    User? user = fAuth.currentUser;
    if (user != null)
      return true;
    else
      return false;
  }

  Future<bool> emailIsVerified() async {
    User? user = fAuth.currentUser;
    if (user != null){
      await user.reload();
      if(user.emailVerified){
        return true;
      }
      else{
        return false;
      }
    }
    else
      {
        return false;
      }
  }




  Future<void> sendEmailVerification() async {
    User? user = fAuth.currentUser;
    if (user != null){
      await user.sendEmailVerification();
    }
    AuthenticationService().signOut();
  }

  Future<void> signOut() async {
    await fAuth.signOut();
  }





  // USER GETTERS AND SETTERS



  String getUserID() {
    User? user = fAuth.currentUser;
    if (user != null){
      return user.uid;
    }
    return "null";
  }




}
