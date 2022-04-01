// @dart=2.9
import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'package:test/routes.dart';

void main() async {
  await Future.delayed(Duration(seconds: 3));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Login.routeName,
      routes: routes,
    );
  }
}
