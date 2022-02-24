import 'package:flutter/material.dart';
import 'package:test/components/setting_menu.dart';
import 'package:test/components/setting_pic.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:test/screens/login.dart';
import 'package:test/screens/my_account.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> logoutSession() async {
      await FlutterSession().set('token', '');
      await FlutterSession().set('token_userid', '');
      await FlutterSession().set('token_username', '');
      await FlutterSession().set('token_role', '');
    }

    void logoutDialog() {
      showDialog(
          context: context,
          builder: (_) => AssetGiffyDialog(
              image: Image.asset(
                'assets/men_wearing_jacket.gif',
                fit: BoxFit.cover,
              ),
              title: Text(
                'LOGOUT',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              description: Text(
                'Are your sure logout?',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              entryAnimation: EntryAnimation.RIGHT,
              onOkButtonPressed: () {
                logoutSession();
                Navigator.of(context, rootNavigator: true)
                    .pushReplacementNamed(Login.routeName);
              },
              onCancelButtonPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                //Navigator.of(context).pop();
              }));
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            SettingPic(),
            SizedBox(height: 20),
            SettingMenu(
              text: "My Account",
              icon: Icon(
                Icons.person_rounded,
                size: 40,
                color: Colors.blue,
              ),
              press: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAccount()))
              },
            ),
            SettingMenu(
              text: "Notifications",
              icon: Icon(
                Icons.notifications_rounded,
                size: 40,
                color: Colors.blue,
              ),
              press: () {},
            ),
            SettingMenu(
              text: "Settings",
              icon: Icon(
                Icons.settings_rounded,
                size: 40,
                color: Colors.blue,
              ),
              press: () {},
            ),
            SettingMenu(
              text: "Help Center",
              icon: Icon(
                Icons.help_center_rounded,
                size: 40,
                color: Colors.blue,
              ),
              press: () {},
            ),
            SettingMenu(
              text: "Log Out",
              icon: Icon(
                Icons.logout_rounded,
                size: 40,
                color: Colors.blue,
              ),
              press: () {
                logoutDialog();
              },
            ),
          ],
        ),
      ),
    );
  }
}
