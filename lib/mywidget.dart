import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

const String title = 'SMC Transpot';
const String version = "ver.0.0.0.1";

const Color smcBaseTheme1 = Color(0xff24ADE3);
const Color smcBaseTheme2 = Color(0xff85D8CE);

// Menu Master -------------------------------------------------------------- //

class MenuButton extends StatelessWidget {
  late final IconData icon;
  late final String subject;
  late final String description;
  late final MaterialPageRoute callback;

  //late final VoidCallback callback; // Notice the variable type

  MenuButton(IconData? icondata, String? subj, String? desc, this.callback) {
    icon = icondata ?? Icons.widgets;
    subject = subj ?? "";
    description = desc ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Card(
            child: InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => callback.buildContent(context)),
        )
      },
      child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(children: <Widget>[
            Container(
              child: MenuIconWidget(icon, true),
            ),
            Container(
              child: MenuTextWidget(subject, description),
            ),
            Spacer(),
            Container(
              child: MenuIconWidget(Icons.keyboard_arrow_right_rounded, false),
            ),
          ])),
    )));
  }
}

Widget MenuIconWidget(IconData icon, bool isMain) {
  if (isMain) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      decoration: BoxDecoration(
          border: Border(
        right: BorderSide(width: 0.25, color: Colors.grey),
      )),
      child: Icon(
        icon,
        color: smcBaseTheme1,
      ),
    );
  } else {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Icon(
        icon,
        color: Colors.grey,
      ),
    );
  }
}

Widget MenuTextWidget(String subject, String description) {
  return Container(
    padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (description != "") ...[
          Text(
            subject,
            style: TextStyle(
                color: Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          Text(
            description,
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          )
        ] else ...[
          Text(
            subject,
            style: TextStyle(
                color: Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 20.0),
          )
        ]
      ],
    ),
  );
}

// Header Master -------------------------------------------------------------- //

class HeaderMaster extends StatefulWidget {
  HeaderMaster(this.pagetitle, this.content, this.canback);

  final String pagetitle;
  final Container content;
  final bool canback;

  @override
  _HeaderMaster createState() => _HeaderMaster(pagetitle, content, canback);
}

class _HeaderMaster extends State<HeaderMaster> {
  _HeaderMaster(this.pagetitle, this.content, this.canback);

  final String pagetitle;
  final Container content;
  final bool canback;

  //final CupertinoPageRoute callback;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var button = null;

    if (canback) {
      button = CupertinoNavigationBarBackButton(
        onPressed: () => Navigator.of(context).pop(),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: title,
      home: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: BackButton(color: Colors.black),
            backgroundColor: Colors.white,

            // leading: BackButton(
            //   color: Colors.white,
            //   onPressed: () => Navigator.push(
            //     context,
            //     callback,
            //   ),
            // ),

            title: Text(
              pagetitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            //backgroundColor: smcBaseTheme1,
            /*flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    0.6,
                  ],
                  colors: [
                    smcBaseTheme2,
                    smcBaseTheme1,
                  ],
                ),
              ),
            ),*/
          ),
          body: Center(
            child: content,
          )),
    );
  }
}

// Popup Dialog ------------------------------------------------------------- //

class PopupDialog extends StatefulWidget {
  const PopupDialog({Key? key}) : super(key: key);

  @override
  _PopupDialog createState() => _PopupDialog();
}

class _PopupDialog extends State<PopupDialog> {
  final apicontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    apicontroller.text = PreferenceUtils?.getString("api");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      title: const Text('Settings'),
      contentPadding: EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: size.width * 0.8,
            child: TextFormField(
              controller: apicontroller,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'API Url',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0),
                    child: Icon(Icons.insert_link),
                  )),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MyPopupButton("Cancel", size.width * 0.8 * 0.2,
                    () => {Navigator.of(context).pop()}),
                MyPopupButton(
                    "Save",
                    size.width * 0.8 * 0.2,
                    () => {
                          PreferenceUtils.setString("api", apicontroller.text),
                          Navigator.of(context).pop()
                        })
              ])
        ],
      ),
    );
  }
}

// Button ------------------------------------------------------------------- //

class MyRowFlex extends StatelessWidget {
  final Widget child;
  final int scale;
  final bool isfirst;
  final bool islast;

  const MyRowFlex(this.scale, this.isfirst, this.islast, this.child);

  @override
  Widget build(BuildContext context) {
    EdgeInsets edgeInsets;

    if (isfirst) {
      edgeInsets = EdgeInsets.only(right: 5);
    } else if (islast) {
      edgeInsets = EdgeInsets.only(left: 5);
    } else {
      edgeInsets = EdgeInsets.only(left: 5, right: 5);
    }

    return Expanded(
      flex: scale,
      child: Container(
        padding: edgeInsets,
        child: child,
      ),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? callback;

  const MyElevatedButton(this.child, this.callback);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: smcBaseTheme1,
        minimumSize: Size.fromHeight(40),
        //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        padding: EdgeInsets.all(0),
      ),
      child: Center(child: child),
      onPressed: callback,
    );
  }
}

class MyIconButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? callback;

  const MyIconButton(this.child, this.callback);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: smcBaseTheme2,
      icon: child,
      onPressed: callback,
    );
  }
}

class MyPopupButton extends StatelessWidget {
  final String text;
  final double width;
  final double height = 40;
  final VoidCallback? callback;

  const MyPopupButton(this.text, this.width, this.callback);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        elevation: 5,
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: callback,
      child: Ink(
        decoration: BoxDecoration(color: Colors.transparent),
        child: Container(
          padding: const EdgeInsets.all(5),
          width: width,
          height: height,
          alignment: Alignment.center,
          //constraints: const BoxConstraints(minWidth: 88.0),
          child: Text(text,
              textAlign: TextAlign.center,
              style: (TextStyle(
                color: Colors.blue,
              ))),
        ),
      ),
    );
  }
}

class MyFloatButton extends StatelessWidget {
  //final Widget child;
  //final double width;
  //final double height = 40;
  final VoidCallback? callback;

  const MyFloatButton(this.callback);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Icon(
            Icons.save,
            //size: 40,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.6,
              ],
              colors: [
                smcBaseTheme2,
                smcBaseTheme1,
              ],
            ),
          )),
      onPressed: callback,
    );
  }
}

// Data Table --------------------------------------------------------------- //

// Dialog --------------------------------------------------------------- //

class MyWidget {
  static void showMyAlertDialog(
      BuildContext context, String type, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          MyWidget.MyAlertDialog(context, type, message),
      // builder: (BuildContext context) {
      //   return MyWidget.MyAlertDialog(context, type, subject, content);
      // },
    );
  }

  static AlertDialog MyAlertDialog(
      BuildContext context, String type, String message) {
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

    return AlertDialog(
      title: Row(children: [icon, Text(" " + type)]),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () => {Navigator.pop(context, 'OK')},
          child: const Text('OK'),
        ),
      ],
    );
  }
}

// class App1 {
//   static SharedPreferences _preferences = await SharedPreferences.getInstance();
//   //static SharedPreferences localStorage;
//   static Future init() async {
//     _preferences = await SharedPreferences.getInstance();
//   }
// }

// class PreferenceUtils {
//   static Future<SharedPreferences> get _instance async =>
//       _prefsInstance ??= await SharedPreferences.getInstance();
//   static SharedPreferences? _prefsInstance;
//
//   // call this method from iniState() function of mainApp().
//   static Future<SharedPreferences?> init() async {
//     _prefsInstance = await _instance;
//     var api = getString("api", "http://192.168.1.49:8111/api/api");
//     setString("api", api);
//
//     return _prefsInstance;
//   }
//
//   static String getString(String key, [String? defValue]) {
//     return _prefsInstance?.getString(key) ?? defValue ?? "";
//   }
//
//   // static Future<bool> setString(String key, String value) async {
//   //   var prefs = await _instance;
//   //   return prefs.setString(key, value) ?? Future.value(false);
//   // }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Material(
//   //       child: FutureBuilder(
//   //           future: FlutterSession().get('token'),
//   //           builder: (context, snapshot) {
//   //             return Text(snapshot.hasData ? snapshot.data : 'Loading...');
//   //           }
//   //       )
//   //   );
//   // }
// }

class PreferenceUtils {
  static late final SharedPreferences instance;
  static bool _init = false;

  static Future init() async {
    if (_init) return;
    instance = await SharedPreferences.getInstance();
    _init = true;

    var api = getString("api", "http://192.168.1.49:8111/api/api");
    setString("api", api);

    return instance;
  }

  static String getString(String key, [String? defValue]) {
    return instance.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) {
    return instance.setString(key, value) ?? Future.value(false);
  }
}
