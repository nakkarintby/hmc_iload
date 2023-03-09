import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/class/login.dart';
import 'package:test/class/phonenocheck.dart';
import 'package:test/class/userLogin.dart';
import 'package:test/class/userLoginResult.dart';
import 'package:test/screens/main_screen.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:location/location.dart';
import 'package:test/screens/menu.dart';

class Login extends StatefulWidget {
  static String routeName = "/Login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late Timer timer;
  TextEditingController configsController = TextEditingController();
  String configs = '';

  @override
  void initState() {
    super.initState();
    setSharedPrefs();
  }

  Future<void> setSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkConfigsPrefs = prefs.containsKey('configs');
    if (checkConfigsPrefs) {
      setState(() {
        configs = prefs.getString('configs');
      });
    } else {
      prefs.setString('configs', 'iloadapi.harmonious.co.th:4445');
    }
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
    alertDialog(error, 'Error');
  }

  void showSuccessDialog(String success) {
    alertDialog(success, 'Success');
  }

  Future<void> showProgressLoading(bool finish) async {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        progress: 50.0,
        message: "Please wait...",
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    if (finish == false) {
      await pr.show();
    } else {
      await pr.hide();
    }
  }

  Future<void> checkLogin() async {
    //await showProgressLoading(false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        configs = prefs.getString('configs');
      });
      var url = Uri.parse('https://' + configs + '/api/User/Login');
      /*var headers = { 
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      };*/
      var headers = {'Content-Type': 'application/json'};
      late UserLogin? userDataLogin = new UserLogin();
      setState(() {
        //userDataLogin.username = usernameController.text;
        //userDataLogin.password = passwordController.text;
        userDataLogin.username = 'user1';
        userDataLogin.password = 'Useruseruser1*';
        userDataLogin.rememberLogin = true;
        userDataLogin.returnUrl = '1';
      });

      var jsonBody = jsonEncode(userDataLogin);
      final encoding = Encoding.getByName('utf-8');

      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        late UserLoginResult result;
        setState(() {
          result = UserLoginResult.fromJson(data);
        });
        prefs.setString('token', result.accesstoken);
        setState(() {
          usernameController.text = '';
          passwordController.text = '';
          _btnController.reset();
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      } else {
        prefs.setString('token', '');
        setState(() {
          usernameController.text = '';
          passwordController.text = '';
          _btnController.reset();
        });
        showErrorDialog('Data Incorrect');
      }
    } catch (e) {
      //await showProgressLoading(true);
      showErrorDialog('Error occured while checkLogin');
    }
  }

  Future<void> editConfigs() async {
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
                TextFormField(
                  //focusNode: focusNodes[3],
                  //autofocus: true, //set initail focus on dialog
                  //keyboardType: TextInputType.number,
                  readOnly: false,
                  controller: configsController
                    ..text = prefs.getString('configs').toString(),
                  decoration: InputDecoration(
                      labelText: 'Configs', hintText: "Enter Url"),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {},
                ),
              ],
            )),
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
                //focusNode: focusNodes[5],
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Save'),
                onPressed: () {
                  setState(() {
                    prefs.setString('configs', configsController.text);
                    Navigator.pop(context);
                  });
                  alertDialog('Edit Successful', 'Success');
                },
              ),
            ],
          );
        });
  }

  Widget _titleWidget() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.19,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/hmc_logo.png',
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.8,
          fit: BoxFit.cover,
        ));
  }

  Widget _bottomWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height / 8,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            //top: MediaQuery.of(context).size.height / 1.135,
            right: MediaQuery.of(context).size.width / 2.5,
            child: Image.asset("assets/shms1.png", width: size.width * 0.38),
          ),
          Positioned(
            //top: MediaQuery.of(context).size.height / 1.135,
            right: MediaQuery.of(context).size.width / 80,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('1.0'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red[400], //
                shape: CircleBorder(),
                padding: EdgeInsets.all(12),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _contextWidget() {
    return Column(
      children: <Widget>[
        _entryFieldUsername("Usernamr", isPassword: false),
        SizedBox(height: 12),
        _entryFieldPassword("Password", isPassword: true),
      ],
    );
  }

  Widget _entryFieldUsername(String title, {bool isPassword = false}) {
    return Visibility(
        visible: true,
        child: TextFormField(
          //keyboardType: TextInputType.number,
          //maxLength: 10,
          controller: usernameController,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            hintText: 'Username',
            //labelText: 'Password',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(10)),
            prefix: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              /*child: Text(
                '(+66)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),*/
            ),
          ),
        ));
  }

  Widget _entryFieldPassword(String title, {bool isPassword = true}) {
    return Visibility(
        visible: true,
        child: TextFormField(
          //keyboardType: TextInputType.number,
          //maxLength: 10,
          controller: passwordController,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),

            hintText: 'Password',
            //labelText: 'Password',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(10)),
            prefix: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              /*child: Text(
                '(+66)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),*/
            ),
          ),
        ));
  }

  Widget _LoginButtonWidget() {
    return InkWell(
        child: Visibility(
      visible: true,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 1),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: RoundedLoadingButton(
            color: Colors.blue.shade300,
            successColor: Color(0xfffbb448).withAlpha(100),
            controller: _btnController,
            //onPressed: () => await checkLogin(),
            onPressed: () async {
              await checkLogin();
            },
            valueColor: Colors.black,
            child: Text('Login', style: TextStyle(color: Colors.white))),
      ),
    ));
  }

  Widget _editWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height / 11,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            //top: MediaQuery.of(context).size.height / 1.135,
            right: MediaQuery.of(context).size.width / 4,
            child: ElevatedButton(
              onPressed: () {
                editConfigs();
              },
              child: const Icon(
                Icons.settings,
                size: 30,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return exit(0);
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xfff7f6fb),
            body: Container(
                child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      _titleWidget(),
                      SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _contextWidget(),
                            SizedBox(height: 24),
                            _LoginButtonWidget(),
                            SizedBox(height: 12),
                            _editWidget(),
                          ],
                        ),
                      ),
                      //SizedBox(height: 12),
                      _bottomWidget(),
                    ],
                  ),
                ),
              ),
            ))));
  }
}
