import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourceecommerce2/FirebaseMessaging.dart';
import 'package:fluttercourceecommerce2/NotificationController.dart';
import 'package:fluttercourceecommerce2/route.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await NotificationController.initializeLocalNotifications(debug: true);
  await NotificationController.initializeRemoteNotifications(debug: true);
  await NotificationController.getInitialNotificationAction();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: MyApp.navigatorKey,
      routerConfig: router,
      theme: ThemeData(
        //useMaterial3: true,
        canvasColor: Colors.white,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          elevation: .5,
          backgroundColor: Colors.white,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          // actionsIconTheme: IconThemeData(
          //   color: Colors.black,
          // ),
        ),
      ),
    );
  }
}
