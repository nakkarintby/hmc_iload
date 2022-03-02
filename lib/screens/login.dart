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
  TextEditingController qualityController = TextEditingController();
  late Timer timer;
  String configs = '';

  late List<FocusNode> focusNodes = List.generate(3, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    setSharedPrefs();
  }

  Future<void> setSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkConfigsPrefs = prefs.containsKey('configs');
    bool checkQualityPrefs = prefs.containsKey('quality');

    if (checkConfigsPrefs && checkQualityPrefs) {
    } else {
      prefs.setString('configs', 'http://192.168.1.49:8111');
      prefs.setInt('quality', 35);
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
            content: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  autofocus: true, //set initail focus on dialog
                  focusNode: focusNodes[0],
                  readOnly: false,
                  controller: configsController
                    ..text = prefs.getString('configs'),
                  decoration: InputDecoration(
                      labelText: 'Configs IP', hintText: "Enter Configs IP"),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    Future.delayed(Duration(milliseconds: 100)).then((_) =>
                        FocusScope.of(context).requestFocus(focusNodes[1]));
                  },
                ),
                TextField(
                  focusNode: focusNodes[1],
                  readOnly: false,
                  controller: qualityController
                    ..text = prefs.getInt('quality').toString(),
                  decoration: InputDecoration(
                      labelText: 'Quality Image',
                      hintText: "Enter Quality Image[0-100]"),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    Future.delayed(Duration(milliseconds: 100)).then((_) =>
                        FocusScope.of(context).requestFocus(focusNodes[2]));
                  },
                ),
              ],
            )),
            /* content: TextField(
              onChanged: (value) {},
              controller: configsController..text = prefs.getString('configs'),
              //decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),*/
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
                focusNode: focusNodes[2],
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Save'),
                onPressed: () {
                  setState(() {
                    prefs.setString('configs', configsController.text);
                    prefs.setInt('quality', int.parse(qualityController.text));
                    Navigator.pop(context);
                  });
                  alertDialog('Edit Configs and Quality Successful', 'Success');
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
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
                        borderSide: BorderSide(color: redColor, width: 1))),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 16,
            ),
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 16,
            ),
            new Positioned(
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text('version 1 by harmonious',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4), fontSize: 13)),
              ),
            )
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          editSharedPrefs();
        },
        backgroundColor: Colors.red[400],
        child: const Icon(Icons.settings),
      ),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                editSharedPrefs();
              },
              backgroundColor: Colors.blue,
              elevation: 1,
              child: const Icon(
                Icons.settings,
                size: 36,
              ),
            ),
            /*FloatingActionButton(
              onPressed: () {
                editSharedPrefs();
              },
              backgroundColor: Colors.red[400],
              child: const Icon(Icons.settings),
            ),*/
          ],
        ),
      ),
    );
  }
}
