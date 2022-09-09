import 'package:test/screens/main_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:test/screens/register.dart';
import 'package:test/screens/test.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  MainScreen.routeName: (context) => MainScreen(),
  Register.routeName: (context) => Register(),
  ExampleHomePage.routeName: (context) => ExampleHomePage(),
};
