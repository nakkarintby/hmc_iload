import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/class/updatepin.dart';
import 'package:test/screens/main_screen.dart';
import 'package:test/screens/register.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late Timer timer;
  String otp = "";
  String configs = "";
  String token = "";
  String passcodeFirst = "";
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 10);
  int confictsOTP = 0;

  @override
  void initState() {
    super.initState();
    sendOTP();
    startTimer();
  }

  void startTimer() {
    setState(() {
      confictsOTP = 60;
    });
    setState(() => myDuration = Duration(seconds: confictsOTP));
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(seconds: confictsOTP));
    startTimer();
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        setState(() {
          otp = "";
        });
        showErrorDialog("Time Out Otp!");
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  Future<void> sendOTP() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        configs = prefs.getString('configs');
        token = prefs.getString('token');
      });
      var url = Uri.parse(configs + '/api/Mobile/GetOTP?token=' + token);
      print(url);
      http.Response response = await http.get(url);
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var otpTemp = response.body.toString();
        //var otpTemp2 = otpTemp[8] + otpTemp[9] + otpTemp[10] + otpTemp[11];
        setState(() {
          otp = otpTemp.toString();
        });
      } else {
        showErrorDialog("Error Https SendOTP!");
      }
    } catch (e) {
      Navigator.pushReplacementNamed(context, Register.routeName);
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
    //MyWidget.showMyAlertDialog(context, "Error", error);
    alertDialog(error, 'Error');
  }

  void showSuccessDialog(String success) {
    //MyWidget.showMyAlertDialog(context, "Success", success);
    alertDialog(success, 'Success');
  }

  Future<void> verifyCheck() async {
    String otpInput = otp1Controller.text +
        otp2Controller.text +
        otp3Controller.text +
        otp4Controller.text;
    if (otp == otpInput) {
      _btnController.reset();
      setState(() {
        otp1Controller.text = '';
        otp2Controller.text = '';
        otp3Controller.text = '';
        otp4Controller.text = '';
      });
      showLockScreenSecond();
      showLockScreenFirst();
    } else {
      _btnController.reset();
      showErrorDialog('OTP Invalid!');
      setState(() {
        otp1Controller.text = '';
        otp2Controller.text = '';
        otp3Controller.text = '';
        otp4Controller.text = '';
      });
    }
  }

  Future<void> showLockScreenFirst() async {
    _showLockScreenFirst(
      context,
      opaque: false,
      cancelButton: Text(
        'Cancel',
        style: const TextStyle(fontSize: 16, color: Colors.white),
        semanticsLabel: 'Cancel',
      ),
    );
  }

  Future<void> showLockScreenSecond() async {
    _showLockScreenSecond(
      context,
      opaque: false,
      cancelButton: Text(
        'Cancel',
        style: const TextStyle(fontSize: 16, color: Colors.white),
        semanticsLabel: 'Cancel',
      ),
    );
  }

  _showLockScreenFirst(
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
              'Create New Passcode',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEnteredFirst,
            cancelButton: cancelButton,
            deleteButton: Text(
              'Delete',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Delete',
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelledFirst,
            digits: digits,
            passwordDigits: 4,
          ),
        ));
  }

  _onPasscodeEnteredFirst(String enteredPasscode) {
    _verificationNotifier.add(true);
    setState(() {
      passcodeFirst = enteredPasscode;
    });
  }

  _onPasscodeCancelledFirst() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  _showLockScreenSecond(
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
              'Enter Re-Passcode',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEnteredSecond,
            cancelButton: cancelButton,
            deleteButton: Text(
              'Delete',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Delete',
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelledSecond,
            digits: digits,
            passwordDigits: 4,
          ),
        ));
  }

  _onPasscodeEnteredSecond(String enteredPasscode) async {
    bool isValid = passcodeFirst == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      stopTimer();
      try {
        String mobile = '';
        setState(() {
          configs = prefs.getString('configs');
          mobile = prefs.getString('mobileTemp');
        });

        var url = Uri.parse(configs +
            '/api/Mobile/UpdatePin/' +
            mobile.toString() +
            '/' +
            passcodeFirst.toString() +
            '?modifiedBy=user');

        http.Response response = await http.put(url);
        var data = json.decode(response.body);
        UpdatePin checkAns = UpdatePin.fromJson(data);

        if (response.statusCode == 200) {
          prefs.setBool('verify', true);
          prefs.setString('mobile', mobile);
          showSuccessDialog('Verify Done!');
        } else {
          showErrorDialog(checkAns.msg.toString());
        }
      } catch (e) {
        Navigator.pushReplacementNamed(context, Register.routeName);
      }

      timer = Timer(Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Register()));
      });
    }
  }

  _onPasscodeCancelledSecond() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(myDuration.inSeconds.remainder(1000));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff7f6fb),
        body: Container(
            child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/otp.png',
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Enter your OTP code number",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Container(
                    padding: EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _textFieldOTP1Widget(first: true, last: false),
                            _textFieldOTP2Widget(first: false, last: false),
                            _textFieldOTP3Widget(first: false, last: false),
                            _textFieldOTP4Widget(first: false, last: true),
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        _VerifyButtonWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$seconds',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    "Didn't you receive any code?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  new InkWell(
                    onTap: () {
                      resetTimer();
                      sendOTP();
                    },
                    child: new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text(
                        "Resend New Code",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }

  Widget _textFieldOTPWidget({required bool first, last}) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width / 6.5,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && otp.length < 4) {
              setState(() {
                otp = otp + value.toString();
              });
            } else if (value.length == 0 && otp.length <= 4) {
              setState(() {
                otp = otp.substring(0, otp.length - 1);
              });
            }

            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            } else if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP1Widget({required bool first, last}) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width / 6.5,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: otp1Controller,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              otp1Controller.text = value;
            });

            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            } else if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP2Widget({required bool first, last}) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width / 6.5,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: otp2Controller,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              otp2Controller.text = value;
            });

            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            } else if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP3Widget({required bool first, last}) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width / 6.5,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: otp3Controller,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              otp3Controller.text = value;
            });

            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            } else if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP4Widget({required bool first, last}) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width / 6.5,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: otp4Controller,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              otp4Controller.text = value;
            });

            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            } else if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  Widget _VerifyButtonWidget() {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: RoundedLoadingButton(
            color: Colors.purple.shade400,
            successColor: Color(0xfffbb448).withAlpha(100),
            //width: 200,
            controller: _btnController,
            onPressed: () => verifyCheck(),
            valueColor: Colors.white,
            //borderRadius: 30,
            child: Text('Verify', style: TextStyle(color: Colors.white))),
      ),
    );
  }
}
