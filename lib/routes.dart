import 'package:test/screens/main_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:test/screens/welcome.dart';
import 'package:test/screens/signin.dart';
import 'package:test/screens/signup.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  MainScreen.routeName: (context) => MainScreen(),
  WelcomePage.routeName: (context) => WelcomePage(),
  SigninPage.routeName: (context) => SigninPage(),
  SignUpPage.routeName: (context) => SignUpPage()
};
