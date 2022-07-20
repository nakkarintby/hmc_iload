import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/class/checkregister.dart';
import 'package:test/class/myuser.dart';
import 'package:test/screens/signin.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignupPage extends StatefulWidget {
  static String routeName = "/signup";
  SignupPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController idCardController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late Timer timer;
  String configs = '';

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      configs = prefs.getString('configs');
    });
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

  Future<void> signUpCheck() async {
    try {
      if (idCardController.text == '') {
        _btnController.reset();
        showErrorDialog('Please Enter IDcard');
        return;
      } else if (userNameController.text == '') {
        _btnController.reset();
        showErrorDialog('Please Enter Username');
        return;
      } else if (passwordController.text == '') {
        _btnController.reset();
        showErrorDialog('Please Enter Password');
        return;
      } else if (rePasswordController.text == '') {
        _btnController.reset();
        showErrorDialog('Please Enter Re-Password');
        return;
      } else if (firstNameController.text == '') {
        _btnController.reset();
        showErrorDialog('Please Enter FirstName');
        return;
      } else if (lastNameController.text == '') {
        _btnController.reset();
        showErrorDialog('Please Enter LastName');
        return;
      } else if (mobileNoController.text == '') {
        _btnController.reset();
        showErrorDialog('Please Enter MobileNo');
        return;
      } else if (passwordController.text != rePasswordController.text) {
        _btnController.reset();
        showErrorDialog('Password Not Match Re-Password');
        passwordController.text = '';
        rePasswordController.text = '';
        return;
      }

      MyUser a = new MyUser();
      setState(() {
        a.id = 1;
        a.uid = "No-Data";
        a.idCard = idCardController.text.toString();
        a.userName = userNameController.text.toString();
        a.password = passwordController.text.toString();
        a.firstName = firstNameController.text.toString();
        a.lastName = lastNameController.text.toString();
        a.mobileNo = mobileNoController.text.toString();
        a.token = "No-Data";
        a.deviceMAC = "No-Data";
        a.status = 1;
        a.createdBy = "Adminsitrator";
        a.createdOn = "2022-07-20T11:57:26";
        a.modifiedBy = "No-Data";
        a.modifiedOn = "2022-07-20T11:57:26";
      });

      final uri = Uri.parse(configs + '/RTLS/CheckRegister');
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(a.toJson());
      final encoding = Encoding.getByName('utf-8');

      /*Map data = {
        "id": 1,
        "uid": "No-Data",
        "idCard": idCardController.text.toString(),
        "userName": userNameController.text.toString(),
        "password": passwordController.text.toString(),
        "firstName": firstNameController.text.toString(),
        "lastName": lastNameController.text.toString(),
        "mobileNo": mobileNoController.text.toString(),
        "token": "No-Data",
        "deviceMAC": "No-Data",
        "status": 1,
        "createdBy": "Adminsitrator",
        "createdOn": "2022-07-20T11:57:26",
        "modifiedBy": "No-Data",
        "modifiedOn": "2022-07-20T11:57:26"
      };
      String body = json.encode(data);*/

      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      var result = json.decode(response.body);
      CheckRegister checkResult = CheckRegister.fromJson(result);

      if (response.statusCode != 200 && response.statusCode != 404) {
        showErrorDialog('Error Http Requests signUpCheck');
        return;
      }

      if (checkResult.status == "200") {
        setState(() {
          idCardController.text = '';
          userNameController.text = '';
          passwordController.text = '';
          rePasswordController.text = '';
          firstNameController.text = '';
          lastNameController.text = '';
          mobileNoController.text = '';
        });
        _btnController.reset();
        showSuccessDialog(checkResult.message.toString());
        return;
      } else if (checkResult.status == "404") {
        setState(() {
          userNameController.text = '';
          passwordController.text = '';
          rePasswordController.text = '';
        });
        _btnController.reset();
        showErrorDialog(checkResult.message.toString());
        return;
      }
    } catch (e) {
      Navigator.pushReplacementNamed(context, SignupPage.routeName);
    }
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _titleWidget() {
    /*return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'H',
          style: TextStyle(
              fontSize: 42, fontWeight: FontWeight.w700, color: Colors.black),
          children: [
            TextSpan(
              text: '-',
              style: TextStyle(color: Colors.yellow.shade800, fontSize: 42),
            ),
            TextSpan(
              text: 'RTLS',
              style: TextStyle(color: Colors.amber.shade900, fontSize: 42),
            ),
          ]),
    );*/

    return Image.asset(
      'assets/RTLS_logo.png',
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.width * .75,
      fit: BoxFit.cover,
    );
  }

  Widget _contextWidget() {
    return Column(
      children: <Widget>[
        _entryFieldIDcard("IDcard"),
        _entryFieldUserName("UserName"),
        _entryFieldPassword("Password", isPassword: true),
        _entryFieldRePassword("Re-Password", isPassword: true),
        _entryFieldFirstName("FirstName"),
        _entryFieldLastName("LastName"),
        _entryFieldMobileNo("MobileNo"),
      ],
    );
  }

  Widget _entryFieldIDcard(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: idCardController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryFieldUserName(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: userNameController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryFieldPassword(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: passwordController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryFieldRePassword(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: rePasswordController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryFieldFirstName(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: firstNameController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryFieldLastName(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: lastNameController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryFieldMobileNo(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: mobileNoController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _signUpButtonWidget() {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: RoundedLoadingButton(
            color: Colors.yellow.shade900,
            successColor: Color(0xfffbb448).withAlpha(100),
            //width: 200,
            controller: _btnController,
            onPressed: () => signUpCheck(),
            valueColor: Colors.black,
            //borderRadius: 30,
            child: Text('Register', style: TextStyle(color: Colors.white))),
      ),
    );
  }

  Widget _signInLabelWidget() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, SigninPage.routeName);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Container(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * 0.05),
                    //_titleWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _contextWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _signUpButtonWidget(),
                    //SizedBox(height: height * .14),
                    _signInLabelWidget(),
                  ],
                ),
              ),
            ),
            //Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
