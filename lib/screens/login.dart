import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:test/components/background_login.dart';
import 'package:test/screens/main_screen.dart';
import 'package:test/class/user.dart';

class Login extends StatefulWidget {
  static String routeName = "/login";
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  TextEditingController usernameController = TextEditingController();
  late Timer timer;
  String configs = '';

  late List<FocusNode> focusNodes = List.generate(1, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    setSharedPrefs();
  }

  void alertDialog(String msg, String type) {
    Icon icon = Icon(Icons.info_outline, color: Colors.lightBlue);
    switch (type) {
      case "Success":
        icon = Icon(Icons.check_circle_outline, color: Colors.lightGreen);
        break;
      case "Error":
        icon = Icon(Icons.error_outline, color: Colors.redAccent);
        break;
      case "Warning":
        icon = Icon(Icons.warning_amber_outlined, color: Colors.orangeAccent);
        break;
      case "Infomation":
        icon = Icon(Icons.info_outline, color: Colors.lightBlue);
        break;
    }

    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          timer = Timer(Duration(seconds: 5), () {
            Navigator.of(context, rootNavigator: true).pop();
          });

          return AlertDialog(
            title: Row(children: [icon, Text(" " + type)]),
            content: Text(msg),
          );
        }).then((val) {
      if (timer.isActive) {
        timer.cancel();
      }
    });
  }

  void showErrorDialog(String error) {
    //MyWidget.showMyAlertDialog(context, "Error", error);
    alertDialog(error, 'Error');
  }

  void showSuccessDialog(String success) {
    //MyWidget.showMyAlertDialog(context, "Success", success);
    alertDialog(success, 'Success');
  }

  Future<void> setSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkConfigsPrefs = prefs.containsKey('configs');

    if (checkConfigsPrefs) {
      prefs.setString('configs', 'https://phoebe.hms-cloud.com:551');
    } else {
      prefs.setString('configs', 'https://phoebe.hms-cloud.com:551');
    }
  }

  Future<void> loginCheck() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        configs = prefs.getString('configs');
      });
      var username = usernameController.text;
      var url = Uri.parse(configs + '/User/GetUser/' + username);
      http.Response response = await http.get(url);
      print(url);
      if (response.statusCode != 200) {
        showErrorDialog('Error Http Requests loginCheck');
        return;
      }

      var data = json.decode(response.body);
      User msg = User.fromJson(data);
      print(msg.toString());

      Timer(Duration(seconds: 3), () async {
        if (msg != null) {
          _btnController.reset();
          Navigator.pushReplacementNamed(context, MainScreen.routeName);
        } else {
          _btnController.reset();
          usernameController.text = '';
          showErrorDialog('Username Incorrect');
        }
      });
    } catch (e) {
      Navigator.pushReplacementNamed(context, Login.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background_Login(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    // icon: Icon(Icons.mail),
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Your Username',
                    labelText: 'Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.red, width: 1))),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RoundedLoadingButton(
                color: Colors.blueAccent,
                successColor: Colors.blue,
                width: 200,
                controller: _btnController,
                onPressed: () => loginCheck(),
                valueColor: Colors.black,
                borderRadius: 30,
                child: Text('LOGIN', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
