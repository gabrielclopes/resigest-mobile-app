import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'AppWidget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  setUpNotification(messaging);

  runApp(AppWidget());
}





void setUpNotification(FirebaseMessaging messaging) async {


  await FirebaseMessaging.instance.subscribeToTopic('main');


  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print("aaaaa");
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Permissão concedida pelo usuário: ${settings.authorizationStatus}');
    _startPushNotificationsHandler(messaging);
  }
  else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('Permissão concedida provisóriamente pelo usuário: ${settings.authorizationStatus}');
    _startPushNotificationsHandler(messaging);
  }
  else {
    print('Permissão negada pelo usuário');
  }


}

void _startPushNotificationsHandler(FirebaseMessaging messaging) async {
  String? token = await messaging.getToken();
  print('TOKEN: $token');

  // Mensagem em foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Recebi uma mensagem enquanto estava em primeiro plano!');
    print('Dados da mensagem: ${message.data}');

    if (message.notification != null) {
      print('A mensagem também continha uma notificação: ${message.notification!
          .title}, ${message.notification!.body}');
    }
  });

  // Background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Mensagem que inicializa o app
  var data = await FirebaseMessaging.instance.getInitialMessage();

  // if(data!.data["message"].length > 0)
  //   showMyDialog(data!.data["message"]);

}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Mensagem recebida em background: ${message.data}");
}