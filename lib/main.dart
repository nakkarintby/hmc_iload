// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:test/screens/main_screen.dart';
import 'package:test/screens/notification.dart';
import 'package:test/screens/profile.dart';
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
      print(token);
      setSessionToken(token);
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
        showNotification(
            msg['notification']['title'], msg['notification']['body']);
        print(" onMessage called ${(msg)}");
      },
    );
    setSharedPrefs();
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
    navigatorKey.currentState
        .push(MaterialPageRoute(builder: (context) => Notifications()));
  }

  Future<void> setSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkConfigsPrefs = prefs.containsKey('configs');

    if (checkConfigsPrefs) {
      prefs.setString('configs', 'http://phoebe.hms-cloud.com:911');
    } else {
      prefs.setString('configs', 'http://phoebe.hms-cloud.com:911');
    }
  }

  Future<void> setSessionToken(String token) async {
    await FlutterSession().set('token', token);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RTLS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      initialRoute: SigninPage.routeName,
      routes: routes,
    );
  }
}
