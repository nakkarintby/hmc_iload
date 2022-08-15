import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/class/getmyuser.dart';
import 'package:test/class/myuser.dart';
import 'package:test/screens/data.dart';
import 'package:http/http.dart' as http;
import 'package:test/screens/signin.dart';

class Profile2 extends StatefulWidget {
  @override
  _Profile2State createState() => _Profile2State();
}

class _Profile2State extends State<Profile2> {
  String configs = '';
  String uid = '';
  static Random random = Random();
  late Timer timer;
  late MyUser result = new MyUser();

  @override
  void initState() {
    super.initState();
    getProfile();
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

  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      configs = prefs.getString('configs');
      uid = prefs.getString('uid');
      print(uid);
    });

    try {
      var url = Uri.parse(configs + '/RTLS/GetMyUser/' + uid);
      http.Response response = await http.get(url);

      var data = json.decode(response.body);
      GetMyUser getmyuser = GetMyUser.fromJson(data);

      if (response.statusCode != 200 && response.statusCode != 404) {
        showErrorDialog('Error Http Requests getProfile');
        return;
      }

      if (getmyuser.status == "200") {
        setState(() {
          result.uid = uid;
          result.idCard = getmyuser.result!.idCard;
          result.userName = getmyuser.result!.userName;
          result.firstName = getmyuser.result!.firstName;
          result.lastName = getmyuser.result!.lastName;
          result.mobileNo = getmyuser.result!.mobileNo;
        });
        return;
      } else if (getmyuser.status == "404") {
        showErrorDialog(getmyuser.message.toString());
        return;
      }
    } catch (e) {
      Navigator.pushReplacementNamed(context, SigninPage.routeName);
    }
  }

  Future<void> logout() async {
    await FlutterSession().set('uid', '');
    Navigator.pushReplacementNamed(context, SigninPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: const Text('Profile'),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.deepOrange.shade300],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.red.shade300,
                      minRadius: 35.0,
                      child: Icon(
                        Icons.call,
                        size: 30.0,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      minRadius: 60.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.red.shade300,
                      minRadius: 35.0,
                      child: IconButton(
                        //color: Colors.blueGrey[300],
                        iconSize: 30,
                        icon: Icon(Icons.logout),
                        onPressed: () {
                          logout();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  result.firstName.toString() +
                      ' ' +
                      result.lastName.toString(),
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                /*Text(
                  'Flutter Developer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),*/
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.deepOrange.shade300,
                    child: ListTile(
                      title: Text(
                        result.uid.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        'UID',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: ListTile(
                      title: Text(
                        result.userName.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        'Username',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'idCard',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    result.idCard.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Mobile No.',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    result.mobileNo.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
