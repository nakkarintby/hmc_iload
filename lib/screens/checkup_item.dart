import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/class/checkupitem.dart';

class CheckupItemPage extends StatefulWidget {
  static String routeName = "/checkupitem";
  @override
  _CheckupItemPageState createState() => _CheckupItemPageState();
}

class _CheckupItemPageState extends State<CheckupItemPage> {
  int value = 0;
  bool radio = false;
  bool backEnable = false;
  bool saveEnable = false;
  bool nextEnable = false;

  TextEditingController remarkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  List<CheckUpItemClass> list = [];
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
      list = [];
      count = 0;
      radio = false;
      value = 0;
      remarkController.text = "";
      dateController.text = "";
      backEnable = false;
      saveEnable = false;
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

      var url = Uri.parse(configs +
          '/api/CheckUpItem/GetByCheckUpHeaderId/' +
          checkupHeaderID.toString());

      print(url);

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
        list = (json.decode(response.body) as List)
            .map((data) => CheckUpItemClass.fromJson(data))
            .toList();
      });
      await setCountListCheckupItem();
      await updateListCheckupItem();
    } catch (e) {
      print("Error occured while setCheckupItem");
    }
  }

  Future<void> setCountListCheckupItem() async {
    for (int i = 0; i < list.length; i++) {
      if (list[i].modifiedBy == null) {
        setState(() {
          count = i;
          print('count is : ' + count.toString());
        });
        return;
      }
    }
  }

  Future<void> updateListCheckupItem() async {
    if (list.length > 0) {
      if (list[count].modifiedBy == null) {
        setState(() {
          radio = false;
          value = 0;
          remarkController.text = "";
          dateController.text = "";
          backEnable = true;
          saveEnable = false;
          nextEnable = false;
        });
      } else if (list[count].modifiedBy != null) {
        //set radio
        if (list[count].isChecked == true) {
          setState(() {
            radio = true;
            value = 1;
          });
        } else if (list[count].isChecked == false) {
          setState(() {
            radio = true;
            value = 2;
          });
        }

        //set remark
        if (list[count].remark == null) {
          setState(() {
            remarkController.text = "";
          });
        } else if (list[count].remark != null) {
          setState(() {
            remarkController.text = list[count].remark!;
          });
        }

        //set date
        if (list[count].dueDate == null) {
          setState(() {
            dateController.text = "";
          });
        } else if (list[count].dueDate != null) {
          var tempdate = list[count].dueDate.toString();
          var splitdate = tempdate.split('T');
          setState(() {
            dateController.text = splitdate[0];
          });
        }

        //set button
        setState(() {
          backEnable = true;
          saveEnable = true;
          nextEnable = true;
        });
      }
    }
  }

  Future<void> saveListCheckupItem() async {
    if (list.length > 0) {
      setState(() {
        if (value == 1) {
          list[count].isChecked = true;
        } else if (value == 2) {
          list[count].isChecked = false;
        }
        list[count].remark = remarkController.text;
        list[count].dueDate = dateController.text;
        list[count].modifiedBy = username;
      });
    }
  }

  Future<void> confirmDialog() async {
    // set up the buttons
    Widget noButton = FlatButton(
      child: Text("No"),
      onPressed: () async {
        setState(() {
          count--;
          backEnable = true;
          saveEnable = true;
          nextEnable = true;
        });
        await updateListCheckupItem();
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () async {
        if (value == 2 && dateController.text.isEmpty) {
          Navigator.of(context, rootNavigator: true).pop();
          showErrorDialog('Please Select Date');
          return;
        } else if (value == 0) {
          Navigator.of(context, rootNavigator: true).pop();
          showErrorDialog('Please Select Data');
          return;
        }
        await saveListCheckupItem();
        setState(() {
          count--;
          backEnable = true;
          saveEnable = true;
          nextEnable = true;
        });
        await updateListCheckupItem();
        Navigator.of(context, rootNavigator: true).pop();
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

  Future<void> backButtonCheckupItem() async {
    if (count == 0) {
      return;
    }
    await confirmDialog();
  }

  Future<void> saveButtonCheckupItem() async {
    if (value == 2 && dateController.text.isEmpty) {
      showErrorDialog('Please Select Date');
      return;
    }
    showSuccessDialog('Save Sucessful');
  }

  Future<void> nextButtonCheckupItem() async {
    if (value == 2 && dateController.text.isEmpty) {
      showErrorDialog('Please Select Date');
      return;
    }
    if (list.length - 1 == count) {
      await saveListCheckupItem();
      showSuccessDialog('Check Finish Please Save!');
      return;
    }

    await saveListCheckupItem();
    setState(() {
      count++;
    });
    await updateListCheckupItem();
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

  Widget RadioButtonYes(String text, int index) {
    return new SizedBox(
        width: 200.0,
        height: 50.0,
        child: OutlineButton(
          onPressed: () {
            setState(() {
              radio = true;
              value = index;
              saveEnable = true;
              nextEnable = true;
            });
          },
          child: Text(
            text,
            style: TextStyle(
              color: (value == index) ? Colors.green : Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          borderSide:
              BorderSide(color: (value == index) ? Colors.green : Colors.black),
        ));
  }

  Widget RadioButtonNo(String text, int index) {
    return new SizedBox(
        width: 200.0,
        height: 50.0,
        child: OutlineButton(
          onPressed: () {
            setState(() {
              radio = true;
              value = index;
              saveEnable = true;
              nextEnable = true;
            });
          },
          child: Text(
            text,
            style: TextStyle(
              color: (value == index) ? Colors.red : Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          borderSide:
              BorderSide(color: (value == index) ? Colors.red : Colors.black),
        ));
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
                height: MediaQuery.of(context).size.height / 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.25,
                  child: Text(
                    (list.length > 0
                        ? (count + 1).toString() +
                            ". " +
                            list[count].detailName.toString()
                        : 'N/A'),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  )),
              SizedBox(height: 25),
              RadioButtonYes("ผ่าน", 1),
              SizedBox(
                height: 25,
              ),
              RadioButtonNo("ไม่ผ่าน", 2),
              SizedBox(height: 25),
              Container(
                padding: new EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 6,
                    right: MediaQuery.of(context).size.width / 6),
                child: SingleChildScrollView(
                    child: TextFormField(
                  minLines: 1,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (value) {},
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.note_alt_outlined, size: 26),
                    filled: true,
                    hintText: 'Enter Remark',
                    labelText: 'Remark',
                    border: OutlineInputBorder(),
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(20), //
                  ),
                  controller: remarkController,
                )),
              ),
              SizedBox(height: 25),
              Container(
                padding: new EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 6,
                    right: MediaQuery.of(context).size.width / 6),
                child: SingleChildScrollView(
                    child: TextFormField(
                  minLines: 1,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (value) {},
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2040));

                    if (pickedDate != null) {
                      /*print(
                          pickedDate);*/ //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      /*print(
                          formattedDate);*/ //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today, size: 26),
                    filled: true,
                    hintText: 'Enter Date',
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(20), //
                  ),
                  controller: dateController,
                )),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment:
                    CrossAxisAlignment.center, //Center Row contents vertically,
                children: <Widget>[
                  new RaisedButton(
                    color: count == 0 ? Colors.grey : Colors.red,
                    child: const Text('Back',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: backEnable
                        ? () async {
                            await backButtonCheckupItem();
                          }
                        : null,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  new RaisedButton(
                    color: saveEnable == true ? Colors.blue : Colors.grey,
                    child: const Text('Save',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: saveEnable
                        ? () async {
                            await saveButtonCheckupItem();
                          }
                        : null,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  new RaisedButton(
                    color: nextEnable == true ? Colors.green : Colors.grey,
                    child: const Text('Next',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: nextEnable
                        ? () async {
                            await nextButtonCheckupItem();
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
