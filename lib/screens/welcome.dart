import 'package:flutter/material.dart';
import 'package:test/screens/signin.dart';
import 'package:test/screens/signup.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class WelcomePage extends StatefulWidget {
  static String routeName = "/welcome";
  WelcomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late FlutterLocalNotificationsPlugin flutterNotificationPlugin;
  @override
  void initState() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

    flutterNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Hello Everyone"),
              content: Text("$payload"),
            ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('a'),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("Notification with Default Sound"),
            onPressed: () {
              notificationDefaultSound();
            },
          ),
          RaisedButton(
            child: Text("Notification without Sound"),
            onPressed: () {
              notificationNoSound();
            },
          ),
          RaisedButton(
            child: Text("Notification with Custom Sound"),
            onPressed: () {
              notificationCustomSound();
            },
          ),
          RaisedButton(
            child: Text(
              "Scheduled",
            ),
            onPressed: () {
              notificationScheduled();
            },
          )
        ],
      )),
    );
  }

  Future notificationDefaultSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Notification Channel ID',
      'Channel Name',
      'Description',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterNotificationPlugin.show(0, 'New Alert',
        'How to show Local Notification', platformChannelSpecifics,
        payload: 'Default Sound');
  }

  Future notificationNoSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Notification Channel ID',
      'Channel Name',
      'Description',
      playSound: false,
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(presentSound: false);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterNotificationPlugin.show(0, 'New Alert',
        'How to show Local Notification', platformChannelSpecifics,
        payload: 'No Sound');
  }

  Future<void> notificationCustomSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Notification Channel ID',
      'Channel Name',
      'Description',
      // sound: 'slow_spring_board',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterNotificationPlugin.show(0, 'New Alert',
        'How to show Local Notification', platformChannelSpecifics,
        payload: 'Custom Sound');
  }

  Future<void> notificationScheduled() async {
    int hour = 19;
    var ogValue = hour;
    int minute = 05;

    var time = Time(hour, minute, 20);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
      importance: Importance.max,
      // sound: 'slow_spring_board',
      ledColor: Color(0xFF3EB16F),
      ledOffMs: 1000,
      ledOnMs: 1000,
      enableLights: true,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterNotificationPlugin.showDailyAtTime(
      4,
      'show daily title',
      'Daily notification shown',
      time,
      platformChannelSpecifics,
      payload: "Hello",
    );

    print('Set at ' + time.minute.toString() + " +" + time.hour.toString());
  }
}
