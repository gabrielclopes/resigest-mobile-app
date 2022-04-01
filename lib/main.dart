import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'AppWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppWidget());
}










