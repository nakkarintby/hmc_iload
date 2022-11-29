import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test/class/checkupitem.dart';

class CheckupItemPage extends StatefulWidget {
  static String routeName = "/checkupitem";
  @override
  _CheckupItemPageState createState() => _CheckupItemPageState();
}

class _CheckupItemPageState extends State<CheckupItemPage> {
  int value = 0;
  bool radio = false;
  bool backEnable = true;
  bool nextEnable = false;
  TextEditingController remarkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  List<CheckupItem> list = [];
  late Timer timer;
  int count = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      value = 0;
      radio = false;
      backEnable = true;
      nextEnable = false;
      dateController.text = "";
      remarkController.text = "";
      list = [];
      count = 3;
    });
    setCheckupItem();
  }

  void setCheckupItem() {
    for (int i = 1; i <= 10; i++) {
      late CheckupItem? a = new CheckupItem();
      setState(() {
        a.checkUpItemID = i;
        a.checkUpHeaderID = 1;
        a.detailNo = i;
        a.detailName = 'ข้อนี้คือข้อที่ ' + i.toString();
        a.modifiedBy = "";
        list.add(a);
      });
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

  Future<void> confirmDialog() async {
    // set up the buttons
    Widget noButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          count--;
          radio = true;
          backEnable = true;
          nextEnable = true;
          if (list[count].isChecked == true) {
            value = 1;
          } else {
            value = 2;
          }
          dateController.text = list[count].dueDate!;
          remarkController.text = list[count].remark!;
        });
      },
    );
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        if (value == 2 && dateController.text.isEmpty) {
          Navigator.of(context, rootNavigator: true).pop();
          showErrorDialog('Please Select Date');
          return;
        } else if (value == 0) {
          Navigator.of(context, rootNavigator: true).pop();
          showErrorDialog('Please Select Data');
          return;
        }
        setState(() {
          if (value == 1) {
            list[count].isChecked = true;
          } else if (value == 2) {
            list[count].isChecked = false;
          }
          list[count].remark = remarkController.text;
          list[count].dueDate = dateController.text;
          list[count].modifiedBy = "a";
        });

        setState(() {
          count--;
          radio = true;
          backEnable = true;
          nextEnable = true;
          if (list[count].isChecked == true) {
            value = 1;
          } else {
            value = 2;
          }
          dateController.text = list[count].dueDate!;
          remarkController.text = list[count].remark!;
        });
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

  Future<void> backCheckupItem() async {
    if (count == 0) {
      return;
    }
    await confirmDialog();
  }

  Future<void> saveCheckupItem() async {
    if (value == 2 && dateController.text.isEmpty) {
      showErrorDialog('Please Select Date');
      return;
    }
    showSuccessDialog('Save Sucessful');
  }

  Future<void> nextCheckupItem() async {
    if (value == 2 && dateController.text.isEmpty) {
      showErrorDialog('Please Select Date');
      return;
    }
    if (list.length - 1 == count) {
      setState(() {
        if (value == 1) {
          list[count].isChecked = true;
        } else if (value == 2) {
          list[count].isChecked = false;
        }
        list[count].remark = remarkController.text;
        list[count].dueDate = dateController.text;
        list[count].modifiedBy = "a";
      });
      showSuccessDialog('Check Finish Please Save!');
      return;
    }

    setState(() {
      if (value == 1) {
        list[count].isChecked = true;
      } else if (value == 2) {
        list[count].isChecked = false;
      }
      list[count].remark = remarkController.text;
      list[count].dueDate = dateController.text;
      list[count].modifiedBy = "a";
    });

    setState(() {
      count++;
    });
    if (list[count].modifiedBy == "") {
      setState(() {
        radio = false;
        backEnable = true;
        nextEnable = false;
        value = 0;
        dateController.text = "";
        remarkController.text = "";
      });
    } else {
      setState(() {
        radio = true;
        backEnable = true;
        nextEnable = true;
        if (list[count].isChecked == true) {
          value = 1;
        } else {
          value = 2;
        }
        dateController.text = list[count].dueDate!;
        remarkController.text = list[count].remark!;
      });
    }
  }

  Widget RadioButtonYes(String text, int index) {
    return new SizedBox(
        width: 200.0,
        height: 50.0,
        child: OutlineButton(
          onPressed: () {
            setState(() {
              value = index;
              radio = true;
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
              value = index;
              radio = true;
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
                    list[count].detailNo.toString() +
                        ". " +
                        list[count].detailName.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
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
                    color: Colors.red,
                    child: const Text('Back',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: backEnable
                        ? () {
                            backCheckupItem();
                          }
                        : null,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  new RaisedButton(
                    color: radio == true ? Colors.blue : Colors.grey,
                    child: const Text('Save',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: nextEnable
                        ? () {
                            saveCheckupItem();
                          }
                        : null,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  new RaisedButton(
                    color: radio == true ? Colors.green : Colors.grey,
                    child: const Text('Next',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: nextEnable
                        ? () {
                            nextCheckupItem();
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
