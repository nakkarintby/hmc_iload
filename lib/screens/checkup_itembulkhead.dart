import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:test/class/checkupitem.dart';
import 'package:http/http.dart' as http;
import 'package:test/screens/checkup_item.dart';
import 'checkup_itembulktail.dart';

class CheckupItemBulkHeadPage extends StatefulWidget {
  static String routeName = "/checkupitembulkhead";
  @override
  _CheckupItemBulkHeadPageState createState() =>
      _CheckupItemBulkHeadPageState();
}

class _CheckupItemBulkHeadPageState extends State<CheckupItemBulkHeadPage> {
  bool button1Enable = false;
  bool button2Enable = false;
  bool button3Enable = false;
  bool button4Enable = false;
  bool button5Enable = false;
  bool button6Enable = false;
  bool button7Enable = false;
  bool button8Enable = false;
  bool button9Enable = false;
  bool button10Enable = false;
  bool button11Enable = false;

  bool backEnable = false;
  bool nextEnable = false;

  List<CheckUpItemClass> list = [];
  List<CheckUpItemClass> listtemp = [];
  late Timer timer;
  int count = 0;
  String configs = "";
  String accessToken = "";
  String username = "";
  int checkupHeaderID = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      listtemp = [];
      list = [];
      backEnable = false;
      nextEnable = false;
    });
    setListCheckupItem();
  }

  Future<void> setListCheckupItem() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        configs = prefs.getString('configs');
        accessToken = prefs.getString('accessToken');
        username = prefs.getString('username');
        checkupHeaderID = prefs.getInt('checkupHeaderID');
      });

      var url = Uri.parse('https://' +
          configs +
          '/api/CheckUpItem/GetByCheckUpHeaderId/' +
          checkupHeaderID.toString());

      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      };

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        showErrorDialog('Not found setCheckupItem');
        return;
      }

      setState(() {
        listtemp = (json.decode(response.body) as List)
            .map((data) => CheckUpItemClass.fromJson(data))
            .toList();
      });

      //set list
      for (int i = 0; i < listtemp.length; i++) {
        if (listtemp[i].detailName == '1' ||
            listtemp[i].detailName == '2' ||
            listtemp[i].detailName == '3' ||
            listtemp[i].detailName == '4' ||
            listtemp[i].detailName == '5' ||
            listtemp[i].detailName == '6' ||
            listtemp[i].detailName == '7' ||
            listtemp[i].detailName == '8' ||
            listtemp[i].detailName == '9' ||
            listtemp[i].detailName == '10' ||
            listtemp[i].detailName == 'ยางอะไหล่') {
          list.add(listtemp[i]);
        }
      }
      await updateListCheckupItemBulkHead();
      return;
    } catch (e) {
      print("Error occured while setCheckupItem");
    }
  }

  Future<void> updateListCheckupItemBulkHead() async {
    for (int i = 0; i < list.length; i++) {
      switch (i) {
        case 0:
          setState(() {
            button1Enable = list[i].isChecked!;
          });
          break;
        case 1:
          setState(() {
            button2Enable = list[i].isChecked!;
          });
          break;
        case 2:
          setState(() {
            button3Enable = list[i].isChecked!;
          });
          break;
        case 3:
          setState(() {
            button4Enable = list[i].isChecked!;
          });
          break;
        case 4:
          setState(() {
            button5Enable = list[i].isChecked!;
          });
          break;
        case 5:
          setState(() {
            button6Enable = list[i].isChecked!;
          });
          break;
        case 6:
          setState(() {
            button7Enable = list[i].isChecked!;
          });
          break;
        case 7:
          setState(() {
            button8Enable = list[i].isChecked!;
          });
          break;
        case 8:
          setState(() {
            button9Enable = list[i].isChecked!;
          });
          break;
        case 9:
          setState(() {
            button10Enable = list[i].isChecked!;
          });
          break;
        case 10:
          setState(() {
            button11Enable = list[i].isChecked!;
          });
          break;
        default:
          // code block
          break;
      }
    }
    setState(() {
      backEnable = true;
      nextEnable = true;
    });
  }

  Future<void> confirmDialog() async {
    // set up the buttons
    Widget noButton = FlatButton(
      child: Text("No"),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pop(context);
      },
    );
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () async {
        await saveListCheckupItemBulkHead();
        await postList();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(children: [
        Icon(Icons.warning_amber_outlined, color: Colors.orangeAccent),
        Text("Warning")
      ]),
      content: Text("Would you like save?"),
      actions: [
        noButton,
        yesButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> backButton() async {
    await confirmDialog();
    //Navigator.pop(context);
  }

  Future<void> nextButton() async {
    await saveListCheckupItemBulkHead();
    await postList();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool havetrailerbulk = prefs.getBool('havetrailerbulk');
    if (havetrailerbulk) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CheckupItemBulkTailPage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CheckupItemPage()));
    }
  }

  Future<void> saveListCheckupItemBulkHead() async {
    for (int i = 0; i < list.length; i++) {
      switch (i) {
        case 0:
          setState(() {
            list[i].isChecked = button1Enable;
          });
          break;
        case 1:
          setState(() {
            list[i].isChecked = button2Enable;
          });
          break;
        case 2:
          setState(() {
            list[i].isChecked = button3Enable;
          });
          break;
        case 3:
          setState(() {
            list[i].isChecked = button4Enable;
          });
          break;
        case 4:
          setState(() {
            list[i].isChecked = button5Enable;
          });
          break;
        case 5:
          setState(() {
            list[i].isChecked = button6Enable;
          });
          break;
        case 6:
          setState(() {
            list[i].isChecked = button7Enable;
          });
          break;
        case 7:
          setState(() {
            list[i].isChecked = button8Enable;
          });
          break;
        case 8:
          setState(() {
            list[i].isChecked = button9Enable;
          });
          break;
        case 9:
          setState(() {
            list[i].isChecked = button10Enable;
          });
          break;
        case 10:
          setState(() {
            list[i].isChecked = button11Enable;
          });
          break;
        default:
          // code block
          break;
      }
    }
  }

  Future<void> postList() async {
    //post list checkupitem
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        configs = prefs.getString('configs');
        accessToken = prefs.getString('accessToken');
        username = prefs.getString('username');
      });

      var url = Uri.parse('https://' + configs + '/api/CheckUpItem/UpdateList');

      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      };

      //set list
      for (int i = 0; i < list.length; i++) {
        list[i].modifiedBy = username;
      }
      var jsonBody = jsonEncode(list);
      final encoding = Encoding.getByName('utf-8');

      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        print("post sucessful");
      } else {
        showErrorDialog('Https Error postList');
      }
    } catch (e) {
      print("Error occured while SaveList");
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

  void showErrorDialog(String error) async {
    //MyWidget.showMyAlertDialog(context, "Error", error);
    alertDialog(error, 'Error');
  }

  void showSuccessDialog(String success) async {
    //MyWidget.showMyAlertDialog(context, "Success", success);
    alertDialog(success, 'Success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50,
            leading: BackButton(color: Colors.black),
            backgroundColor: Colors.white,
            title: Text(
              'CHECK-UP',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontSize: 18),
            )),
        resizeToAvoidBottomInset: false,
        body: Container(
            child: SingleChildScrollView(
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 24),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.25,
                  child: const Text(
                    "รายการตรวจสภาพยางส่วนหัว",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // red as border color
                    ),
                  ),
                  child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Row contents vertically,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button1Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(55, 55), //////// HERE
                              ),
                              onPressed: () async {
                                setState(() => button1Enable = !button1Enable);
                                //await checkEnable();
                              },
                              child: Text('1'),
                            ),
                            SizedBox(width: 100),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button2Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(55, 55), //////// HERE
                              ),
                              onPressed: () async {
                                setState(() => button2Enable = !button2Enable);
                                //await checkEnable();
                              },
                              child: Text('2'),
                            ),
                          ],
                        ),
                        SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Row contents vertically,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button3Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(55, 55), //////// HERE
                              ),
                              onPressed: () async {
                                setState(() => button3Enable = !button3Enable);
                                //await checkEnable();
                              },
                              child: Text('3'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button4Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(55, 55), //////// HERE
                              ),
                              onPressed: () async {
                                setState(() => button4Enable = !button4Enable);
                                //await checkEnable();
                              },
                              child: Text('4'),
                            ),
                            SizedBox(width: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button5Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(55, 55), //////// HERE
                              ),
                              onPressed: () async {
                                setState(() => button5Enable = !button5Enable);
                                //await checkEnable();
                              },
                              child: Text('5'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button6Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(55, 55), //////// HERE
                              ),
                              onPressed: () async {
                                setState(() => button6Enable = !button6Enable);
                                //await checkEnable();
                              },
                              child: Text('6'),
                            ),
                          ],
                        ),
                        SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Row contents vertically,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button7Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(55, 55), //////// HERE
                              ),
                              onPressed: () async {
                                setState(() => button7Enable = !button7Enable);
                                //await checkEnable();
                              },
                              child: Text('7'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button8Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(55, 55), //////// HERE
                              ),
                              onPressed: () async {
                                setState(() => button8Enable = !button8Enable);
                                //await checkEnable();
                              },
                              child: Text('8'),
                            ),
                            SizedBox(width: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button9Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(55, 55), //////// HERE
                              ),
                              onPressed: () async {
                                setState(() => button9Enable = !button9Enable);
                                //await checkEnable();
                              },
                              child: Text('9'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button10Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(55, 55), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button10Enable = !button10Enable);
                                //await checkEnable();
                              },
                              child: Text('10'),
                            ),
                          ],
                        ),
                        SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Row contents vertically,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button11Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(55, 55), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button11Enable = !button11Enable);
                                //await checkEnable();
                              },
                              child: Text('N/A'),
                            ),
                          ],
                        ),
                      ]))),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment:
                    CrossAxisAlignment.center, //Center Row contents vertically,
                children: <Widget>[
                  new RaisedButton(
                    color: backEnable == true ? Colors.red : Colors.grey,
                    child: const Text('Back',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: backEnable
                        ? () async {
                            await backButton();
                          }
                        : null,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                  new RaisedButton(
                    color: nextEnable == true ? Colors.green : Colors.grey,
                    child: const Text('Next',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: nextEnable
                        ? () async {
                            await nextButton();
                          }
                        : null,
                  ),
                ],
              ),
            ],
          )),
        )));
  }
}
