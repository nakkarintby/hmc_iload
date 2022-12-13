import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:test/class/checkupitem.dart';
import 'package:http/http.dart' as http;
import 'package:test/screens/checkup_item.dart';
import 'checkup_itembulktail.dart';

class CheckupItemBulkTailPage extends StatefulWidget {
  static String routeName = "/checkupitembulktail";
  @override
  _CheckupItemBulkTailPageState createState() =>
      _CheckupItemBulkTailPageState();
}

class _CheckupItemBulkTailPageState extends State<CheckupItemBulkTailPage> {
  bool button11Enable = false;
  bool button12Enable = false;
  bool button13Enable = false;
  bool button14Enable = false;
  bool button15Enable = false;
  bool button16Enable = false;
  bool button17Enable = false;
  bool button18Enable = false;
  bool button19Enable = false;
  bool button20Enable = false;
  bool button21Enable = false;
  bool button22Enable = false;

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

      //check bulk and delete
      String temp = prefs.getString('truckType');
      if (temp == 'BulkTruck') {
        //set list
        for (int i = 0; i < listtemp.length; i++) {
          if (listtemp[i].detailName == '11' ||
              listtemp[i].detailName == '12' ||
              listtemp[i].detailName == '13' ||
              listtemp[i].detailName == '14' ||
              listtemp[i].detailName == '15' ||
              listtemp[i].detailName == '16' ||
              listtemp[i].detailName == '17' ||
              listtemp[i].detailName == '18' ||
              listtemp[i].detailName == '19' ||
              listtemp[i].detailName == '20' ||
              listtemp[i].detailName == '21' ||
              listtemp[i].detailName == '22') {
            list.add(listtemp[i]);
          }
        }
        print(list.length);
        await updateListCheckupItemBulkTail();
        return;
      }
    } catch (e) {
      print("Error occured while setCheckupItem");
    }
  }

  Future<void> updateListCheckupItemBulkTail() async {
    for (int i = 0; i < list.length; i++) {
      switch (i) {
        case 0:
          setState(() {
            button11Enable = list[i].isChecked!;
          });
          break;
        case 1:
          setState(() {
            button12Enable = list[i].isChecked!;
          });
          break;
        case 2:
          setState(() {
            button13Enable = list[i].isChecked!;
          });
          break;
        case 3:
          setState(() {
            button14Enable = list[i].isChecked!;
          });
          break;
        case 4:
          setState(() {
            button15Enable = list[i].isChecked!;
          });
          break;
        case 5:
          setState(() {
            button16Enable = list[i].isChecked!;
          });
          break;
        case 6:
          setState(() {
            button17Enable = list[i].isChecked!;
          });
          break;
        case 7:
          setState(() {
            button18Enable = list[i].isChecked!;
          });
          break;
        case 8:
          setState(() {
            button19Enable = list[i].isChecked!;
          });
          break;
        case 9:
          setState(() {
            button20Enable = list[i].isChecked!;
          });
          break;
        case 10:
          setState(() {
            button21Enable = list[i].isChecked!;
          });
          break;
        case 11:
          setState(() {
            button22Enable = list[i].isChecked!;
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

  /* Future<void> checkEnable() async {
    if (button1Enable ||
        button2Enable ||
        button3Enable ||
        button4Enable ||
        button5Enable ||
        button6Enable ||
        button7Enable ||
        button8Enable ||
        button9Enable ||
        button10Enable) {
      setState(() {
        backEnable = true;
        nextEnable = true;
      });
    } else {
      setState(() {
        backEnable = true;
        nextEnable = false;
      });
    }
  }*/

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
        await saveListCheckupItemBulkTail();
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
    await saveListCheckupItemBulkTail();
    await postList();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CheckupItemPage()));
  }

  Future<void> saveListCheckupItemBulkTail() async {
    for (int i = 0; i < list.length; i++) {
      switch (i) {
        case 0:
          setState(() {
            list[i].isChecked = button11Enable;
          });
          break;
        case 1:
          setState(() {
            list[i].isChecked = button12Enable;
          });
          break;
        case 2:
          setState(() {
            list[i].isChecked = button13Enable;
          });
          break;
        case 3:
          setState(() {
            list[i].isChecked = button14Enable;
          });
          break;
        case 4:
          setState(() {
            list[i].isChecked = button15Enable;
          });
          break;
        case 5:
          setState(() {
            list[i].isChecked = button16Enable;
          });
          break;
        case 6:
          setState(() {
            list[i].isChecked = button17Enable;
          });
          break;
        case 7:
          setState(() {
            list[i].isChecked = button18Enable;
          });
          break;
        case 8:
          setState(() {
            list[i].isChecked = button19Enable;
          });
          break;
        case 9:
          setState(() {
            list[i].isChecked = button20Enable;
          });
          break;
        case 10:
          setState(() {
            list[i].isChecked = button21Enable;
          });
          break;
        case 11:
          setState(() {
            list[i].isChecked = button22Enable;
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 26,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.25,
                  child: const Text(
                    "รายการตรวจสภาพยางส่วนหาง",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(height: 25),
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
                                    button11Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(60, 60), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button11Enable = !button11Enable);
                                //await checkEnable();
                              },
                              child: Text('11'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button12Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(60, 60), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button12Enable = !button12Enable);
                                //await checkEnable();
                              },
                              child: Text('12'),
                            ),
                            SizedBox(width: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button13Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(60, 60), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button13Enable = !button13Enable);
                                //await checkEnable();
                              },
                              child: Text('13'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button14Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(60, 60), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button14Enable = !button14Enable);
                                //await checkEnable();
                              },
                              child: Text('14'),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Row contents vertically,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button15Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(60, 60), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button15Enable = !button15Enable);
                                //await checkEnable();
                              },
                              child: Text('15'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button16Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(60, 60), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button16Enable = !button16Enable);
                                //await checkEnable();
                              },
                              child: Text('16'),
                            ),
                            SizedBox(width: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button17Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(60, 60), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button17Enable = !button17Enable);
                                //await checkEnable();
                              },
                              child: Text('17'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button18Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(60, 60), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button18Enable = !button18Enable);
                                //await checkEnable();
                              },
                              child: Text('18'),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Row contents vertically,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button19Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(60, 60), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button19Enable = !button19Enable);
                                //await checkEnable();
                              },
                              child: Text('19'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button20Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(60, 60), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button20Enable = !button20Enable);
                                //await checkEnable();
                              },
                              child: Text('20'),
                            ),
                            SizedBox(width: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button21Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(60, 60), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button21Enable = !button21Enable);
                                //await checkEnable();
                              },
                              child: Text('21'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    button22Enable ? Colors.blue : Colors.grey,
                                onPrimary: Colors.white,
                                shadowColor: Colors.greenAccent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(60, 60), //////// HERE
                              ),
                              onPressed: () async {
                                setState(
                                    () => button22Enable = !button22Enable);
                                //await checkEnable();
                              },
                              child: Text('22'),
                            ),
                          ],
                        ),
                      ]))),
              SizedBox(height: 25),
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
