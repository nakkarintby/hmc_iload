import 'package:test/screens/main_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:test/screens/notification.dart';
import 'package:test/screens/profile.dart';
import 'package:test/screens/signin.dart';
import 'package:test/screens/signup.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  MainScreen.routeName: (context) => MainScreen(),
  SigninPage.routeName: (context) => SigninPage(),
  SignupPage.routeName: (context) => SignupPage(),
  Notifications.routeName: (context) => Notifications(),
  Profile.routeName: (context) => Profile()
};
