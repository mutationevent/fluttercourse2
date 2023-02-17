import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

initializeFirebase() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('firebase token => $fcmToken');
  //SharedPrefs.setFCMToken(fcmToken.toString());
  //TODO: update stored fcm when token change

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //print('Got a message whilst in the foreground!');
    print('message : ${message.notification?.title}');

    // await AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         id: -1, channelKey: 'alerts', title: 'test', body: 'content'));
    // if (message.notification != null) {
    //   print('Message also contained a notification: ${message.notification}');
    //   print(message.notification?.body.toString());
    //   print(message.notification?.title.toString());
    // }
  });
}
