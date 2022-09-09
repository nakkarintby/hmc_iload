import 'dart:convert';
import 'dart:io';
//0987654321
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/class/checkregister.dart';
import 'package:test/class/user.dart';
import 'package:test/screens/main_screen.dart';
import 'package:test/screens/otp.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

class Register extends StatefulWidget {
  static String routeName = "/register";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController mobileController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late Timer timer;
  String configs = '';
  String token = '';
  bool firsttime = true;
  String passcodeAns = "";
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  bool verify = false;
  String mobileVerify = '';

  @override
  void initState() {
    super.initState();
    setSharedPrefs();
    getSharedPrefs();
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => checkPasscode(context));
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  Future<void> setSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkConfigsPrefs = prefs.containsKey('configs');
    bool checkVerify = prefs.containsKey('verify');
    if (!checkConfigsPrefs) {
      prefs.setString('configs', 'https://phoebe.hms-cloud.com:2745');
    } else {
      prefs.setString('configs', 'https://phoebe.hms-cloud.com:2745');
    }
    if (!checkVerify) {
      prefs.setBool('verify', false);
    }
  }

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      configs = prefs.getString('configs');
      token = prefs.getString('token');
    });
  }

  Future<void> checkPasscode(BuildContext contexts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      verify = prefs.getBool('verify');
    });
    if (verify == true) {
      setState(() {
        passcodeAns = "1234";
      });
      _showLockScreen(
        context,
        opaque: false,
        cancelButton: Text(
          'Cancel',
          style: const TextStyle(fontSize: 16, color: Colors.white),
          semanticsLabel: 'Cancel',
        ),
      );
    } else {
      showErrorDialog("Not Verify!");
    }
  }

  _showLockScreen(
    BuildContext context, {
    required bool opaque,
    CircleUIConfig? circleUIConfig,
    KeyboardUIConfig? keyboardUIConfig,
    required Widget cancelButton,
    List<String>? digits,
  }) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PasscodeScreen(
            title: Text(
              'Enter App Passcode',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: cancelButton,
            deleteButton: Text(
              'Delete',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Delete',
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelled,
            digits: digits,
            passwordDigits: 4,
          ),
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = passcodeAns == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      timer = Timer(Duration(seconds: 1), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      });
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
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

  Future<void> checkRegister() async {
    if (mobileController.text.length != 10) {
      _btnController.reset();
      showErrorDialog('Please Enter Mobile');
      return;
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        configs = prefs.getString('configs');
      });
      var mobile = mobileController.text;
      var url = Uri.parse(configs + '/HMC/CheckRegister/' + mobile);
      http.Response response = await http.get(url);

      var data = json.decode(response.body);
      CheckRegister checkAns = CheckRegister.fromJson(data);

      Timer(Duration(seconds: 3), () async {
        if (checkAns.status == "200") {
          _btnController.reset();
          mobileController.text = '';
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Otp()));
        } else if (checkAns.status == "404") {
          _btnController.reset();
          mobileController.text = '';
          showErrorDialog(checkAns.message.toString());
        }
      });
    } catch (e) {
      Navigator.pushReplacementNamed(context, Register.routeName);
    }
  }

  Widget _titleWidget() {
    return Container(
        height: MediaQuery.of(context).size.height * .25,
        width: MediaQuery.of(context).size.width * 1.5,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/hmc_logo.png',
          height: MediaQuery.of(context).size.height * .25,
          width: MediaQuery.of(context).size.width * 1.5,
          fit: BoxFit.cover,
        ));
  }

  Widget _contextWidget() {
    return Column(
      children: <Widget>[
        _entryFieldMobile("Mobile Number", isPassword: false),
      ],
    );
  }

  Widget _entryFieldMobile(String title, {bool isPassword = false}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 10,
      controller: mobileController,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(10)),
        prefix: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '(+66)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _RegisterButtonWidget() {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: RoundedLoadingButton(
            color: Colors.blue.shade300,
            successColor: Color(0xfffbb448).withAlpha(100),
            //width: 200,
            controller: _btnController,
            onPressed: () => checkRegister(),
            valueColor: Colors.black,
            //borderRadius: 30,
            child: Text('Register', style: TextStyle(color: Colors.white))),
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
                      SizedBox(height: 20),
                      _titleWidget(),
                      SizedBox(height: 36),
                      Container(
                        padding: EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _contextWidget(),
                            SizedBox(height: 12),
                            _RegisterButtonWidget()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))));
  }
}
