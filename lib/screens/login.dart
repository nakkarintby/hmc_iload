import 'package:flutter/material.dart';
import 'package:test/class/datauser.dart';
import 'package:test/mywidget.dart';
import 'package:test/screens/main_screen.dart';
import 'package:test/constants.dart';
import 'package:test/components/background_login.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  TextEditingController configsController = TextEditingController();
  late Timer timer;
  String configs = '';

  @override
  void initState() {
    super.initState();
    setSharedPrefs();
  }

  Future<void> setSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkPrefs = prefs.containsKey('configs');

    if (checkPrefs) {
    } else {
      prefs.setString('configs', configs + '');
    }
  }

  Future<void> editSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Icon icon = Icon(Icons.edit, color: Colors.lightBlue);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [icon, Text(" " + 'Edit Configs')]),
            content: TextField(
              onChanged: (value) {},
              controller: configsController..text = prefs.getString('configs'),
              //decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Cancel'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Save'),
                onPressed: () {
                  setState(() {
                    prefs.setString('configs', configsController.text);
                    Navigator.pop(context);
                  });
                  alertDialog('Edit Configs Successful', 'Success');
                },
              ),
            ],
          );
        });
  }

  void incorrectUsernameDialog() {
    //MyWidget.showMyAlertDialog(context, "Error", 'Username Incorrect');
    alertDialog('Username Incorrect', 'Error');
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
          timer = Timer(Duration(seconds: 2), () {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future<void> login_check() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        setState(() {
          configs = prefs.getString('configs');
        });
        var username = usernameController.text;
        var url = Uri.parse(configs + '/api/api/user/validateuser/' + username);
        http.Response response = await http.get(url);
        var data = json.decode(response.body);
        DataUser msg = DataUser.fromJson(data);
        var msg_userid = msg.user?.userId;
        var msg_username = msg.user?.userName;
        var msg_password = msg.user?.password;
        var msg_role = msg.user?.role;
        var msg_user = msg.user;
        var msg_err = msg.errorMsg;

        Timer(Duration(seconds: 3), () async {
          if (msg_username != null) {
            await FlutterSession().set('token', msg_username);
            await FlutterSession().set('token_userid', msg_userid);
            await FlutterSession().set('token_username', msg_username);
            await FlutterSession().set('token_role', msg_role);
            _btnController.reset();
            Navigator.pushReplacementNamed(context, MainScreen.routeName);
          } else {
            _btnController.reset();
            usernameController.text = '';
            incorrectUsernameDialog();
          }
        });
      } catch (e) {
        Navigator.pushReplacementNamed(context, Login.routeName);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background_Login(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.08),
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
                        borderSide: BorderSide(color: redColor, width: 1))),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RoundedLoadingButton(
                color: roundedLoadingButtonColor,
                successColor: roundedLoadingButtonSuccessColor,
                width: 200,
                controller: _btnController,
                onPressed: () => login_check(),
                valueColor: Colors.black,
                borderRadius: 30,
                child: Text('LOGIN', style: TextStyle(color: whiteColor)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editSharedPrefs();
        },
        backgroundColor: Colors.red[400],
        child: const Icon(Icons.settings),
      ),
    );
  }
}
