// @dart=2.9
import 'package:flutter/material.dart';
import 'package:test/screens/signin.dart';
import 'package:test/routes.dart';
import 'package:test/screens/signup.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await Future.delayed(Duration(seconds: 3));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var platform = new InitializationSettings(android: android);
    flutterLocalNotificationsPlugin.initialize(platform);
    firebaseCloudMessaging_Listeners();
    setSharedPrefs();
  }

  void firebaseCloudMessaging_Listeners() {
    firebaseMessaging.getToken().then((token) {
      print(token);
    });

    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) async {
        print(" onLaunch called ${(msg)}");
      },
      onResume: (Map<String, dynamic> msg) async {
        print(" onResume called ${(msg)}");
      },
      onMessage: (Map<String, dynamic> msg) async {
        showNotification(msg);
        print(" onMessage called ${(msg)}");
      },
    );
  }

  showNotification(Map<String, dynamic> msg) async {
    var title = msg['notification']['title'].toString();
    var body = msg['notification']['body'].toString();

    var android = new AndroidNotificationDetails(
      'CHANNLE ID',
      "CHANNLE NAME",
      "CHANNLE lDescription",
    );
    var platform = new NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(0, title, body, platform);
  }

  Future<void> setSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkConfigsPrefs = prefs.containsKey('configs');

    if (checkConfigsPrefs) {
      prefs.setString('configs', 'http://phoebe.hms-cloud.com:147');
    } else {
      prefs.setString('configs', 'http://phoebe.hms-cloud.com:147');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RTLS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SigninPage.routeName,
      routes: routes,
    );
  }
}
