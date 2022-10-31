// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:test/screens/home.dart';
import 'package:test/screens/main_screen.dart';
import 'package:test/screens/ocr.dart';
import 'package:test/screens/register.dart';
import 'package:test/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  await Future.delayed(Duration(seconds: 3));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    firebaseMessaging.getToken().then((token) {
      setSessionToken(token);
      print('Token : ' + token);
    });

    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) async {
        handleClickedNotification();
        print(" onLaunch called ${(msg)}");
      },
      onResume: (Map<String, dynamic> msg) async {
        handleClickedNotification();
        print(" onResume called ${(msg)}");
      },
      onMessage: (Map<String, dynamic> msg) async {
        showNotification('OTP', msg['notification']['body']);
        print(" onMessage called ${(msg)}");
      },
    );
  }

  Future onSelectNotification(String payload) async {
    handleClickedNotification();
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance: Importance.max,
        playSound: true,
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }

  handleClickedNotification() {
    // Put your logic here before redirecting to your material page route if you want too
    /*navigatorKey.currentState
        .push(MaterialPageRoute(builder: (context) => Notifications()));*/
  }

  Future<void> setSessionToken(String token) async {
    await FlutterSession().set('token', token);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkTokenPrefs = prefs.containsKey('token');
    if (checkTokenPrefs) {
      prefs.setString('token', token);
    } else {
      prefs.setString('token', token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      initialRoute: Register.routeName,
      routes: routes,
    );
  }
}
