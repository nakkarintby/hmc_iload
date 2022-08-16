import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test/class/getmyuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/class/myuser.dart';
import 'package:test/screens/edit_idcard.dart';
import 'package:test/screens/edit_mobile.dart';
import 'package:test/screens/edit_name.dart';
import 'package:test/screens/signin.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String configs = '';
  String uid = '';
  late Timer timer;
  static Random random = Random();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: const Text('Edit Profile'),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Center(
              child: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
          )),
          CircleAvatar(
            backgroundColor: Colors.white70,
            minRadius: 60.0,
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(
                "assets/profile${random.nextInt(6)}.png",
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
          )),
          buildUserInfoDisplay(
              result.firstName.toString() + "  " + result.lastName.toString(),
              'Name',
              EditNameFormPage()),
          Center(
              child: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
          )),
          buildUserInfoDisplay(
              result.idCard.toString(), 'IDCard', EditIDCardFormPage()),
          Center(
              child: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
          )),
          buildUserInfoDisplay(
              result.mobileNo.toString(), 'MobileNo', EditMobileFormPage())
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(
                                  fontSize: 16,
                                  height: 1.4,
                                  color: Colors.black),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
