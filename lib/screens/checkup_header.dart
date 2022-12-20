import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/class/checkupheader.dart';
import 'package:test/class/createcheckupheader.dart';
import 'package:test/class/driver.dart';
import 'package:test/class/truck.dart';
import 'package:test/screens/checkup_item.dart';
import 'package:test/screens/checkup_itembulkhead.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CheckupHeader extends StatefulWidget {
  static String routeName = "/checkupheader";
  @override
  _CheckupHeaderPageState createState() => _CheckupHeaderPageState();
}

class _CheckupHeaderPageState extends State<CheckupHeader> {
  TextEditingController truckPlateController = TextEditingController();
  bool truckPlateReadonly = false;
  Color truckPlateColor = Color(0xFFFFFFFF);
  TextEditingController trailerPlateController = TextEditingController();
  bool trailerPlateReadonly = false;
  Color trailerPlateColor = Color(0xFFFFFFFF);
  TextEditingController truckTypeController = TextEditingController();
  bool truckTypeReadonly = false;
  Color truckTypeColor = Color(0xFFFFFFFF);
  bool backEnable = false;
  bool searchEnable = false;
  bool nextEnable = false;
  bool showDetail = false;
  late Timer timer;

  String configs = '';
  String accessToken = '';
  String username = '';

  List<String> listdriver = [];

  String selectedValue = "";
  Truck? truckPlate;
  Truck? trailerPlate;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setState(() {
      searchEnable = true;
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

  Future<void> validateTruckPlate() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        configs = prefs.getString('configs');
        accessToken = prefs.getString('accessToken');
      });

      var url = Uri.parse('https://' +
          configs +
          '/api/Truck/GetByTruckPlate/' +
          truckPlateController.text.toString());

      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      };

      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 204) {
        setState(() {
          truckPlateController.text = "";
          trailerPlateController.text = "";
        });
        showErrorDialog('Truck Plate Not Found!');
        return;
      }
      var data = json.decode(response.body);
      truckPlate = Truck.fromJson(data);

      if (response.statusCode == 200) {
        if (trailerPlateController.text.toString().isNotEmpty) {
          await validateTrailerPlate();
        } else {
          setState(() {
            truckTypeController.text = truckPlate!.truckType!;
          });
          await validateDetail();
        }
      } else {
        setState(() {
          truckPlateController.text = "";
          trailerPlateController.text = "";
        });
        showErrorDialog('Truck Plate Not Found!');
        return;
      }
    } catch (e) {
      print("Error occured while validateTruckPlate");
    }
  }

  Future<void> validateTrailerPlate() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        configs = prefs.getString('configs');
        accessToken = prefs.getString('accessToken');
      });

      var url = Uri.parse('https://' +
          configs +
          '/api/Truck/GetByTrailerPlate/' +
          trailerPlateController.text.toString());

      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      };

      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 204) {
        setState(() {
          truckPlateController.text = "";
          trailerPlateController.text = "";
        });
        showErrorDialog('Trailer Plate Not Found!');
        return;
      }
      var data = json.decode(response.body);
      trailerPlate = Truck.fromJson(data);

      if (response.statusCode == 200) {
        setState(() {
          truckTypeController.text = trailerPlate!.truckType!;
        });
        await validateDetail();
      } else {
        setState(() {
          truckPlateController.text = "";
          trailerPlateController.text = "";
        });
        showErrorDialog('Trailer Plate Not Found!');
        return;
      }
    } catch (e) {
      print("Error occured while validateTrailerPlate");
    }
  }

  Future<void> validateDetail() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        configs = prefs.getString('configs');
        accessToken = prefs.getString('accessToken');
      });

      var url = Uri.parse('https://' + configs + '/api/User/GetDriver/All');
      var headers = {'Content-Type': 'application/json'};

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<Driver> listtemp = [];
        setState(() {
          listtemp = (json.decode(response.body) as List)
              .map((data) => Driver.fromJson(data))
              .toList();
        });
        for (int i = 0; i < listtemp.length; i++) {
          listdriver.add(listtemp[i].firstName!);
        }
        setState(() {
          showDetail = true;
          backEnable = true;
          searchEnable = false;
          nextEnable = true;
          truckPlateColor = Color(0xFFEEEEEE);
          truckPlateReadonly = true;
          trailerPlateColor = Color(0xFFEEEEEE);
          trailerPlateReadonly = true;
          truckTypeColor = Color(0xFFEEEEEE);
          truckTypeReadonly = true;
          selectedValue = listdriver[0];
        });
      } else {
        showErrorDialog('Driver Not Found');
        return;
      }
    } catch (e) {
      print("Error occured while validateDetail");
    }
  }

  Future<void> checkHeader() async {
    try {
      String path = "";
      //set url
      if (trailerPlateController.text.toString().isEmpty) {
        setState(() {
          path = "/api/CheckUpHeader/GetByLicensePlate?truckplate=" +
              truckPlateController.text.toString();
        });
      } else {
        setState(() {
          path = "/api/CheckUpHeader/GetByLicensePlate?truckplate=" +
              truckPlateController.text.toString() +
              "&trailerplate=" +
              trailerPlateController.text.toString();
        });
      }

      //call api
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        configs = prefs.getString('configs');
        //accessToken = prefs.getString('accessToken');
      });

      var url = Uri.parse('https://' + configs + path);
      var headers = {"Content-Type": "application/json"};

      http.Response response = await http.get(url, headers: headers);
      //create checkup header
      if (response.statusCode == 204) {
        print("not found header");
        await createHeader();
        return;
      }
      var data = json.decode(response.body);
      CheckUpHeaderClass checkHeader = CheckUpHeaderClass.fromJson(data);
      //get checkup header
      if (response.statusCode == 200) {
        print("found header");
        setState(() {
          prefs.setInt('checkupHeaderID', checkHeader.checkUpHeaderID);
        });
        if (checkHeader.truckType == 'Truck') {
          if (trailerPlateController.text.isEmpty) {
            setState(() {
              prefs.setInt('typeCheckUp', 2);
            });
          } else {
            setState(() {
              prefs.setInt('typeCheckUp', 3);
            });
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckupItemBulkHeadPage()));
        } else {
          setState(() {
            prefs.setInt('typeCheckUp', 1);
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CheckupItemPage()));
        }
        //create checkup header
      } else {
        await createHeader();
        return;
      }
    } catch (e) {
      print("Error occured while checkLicense");
    }
  }

  Future<void> createHeader() async {
    //post list createHeader
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        configs = prefs.getString('configs');
        username = prefs.getString('username');
      });

      var url = Uri.parse('https://' + configs + '/api/CheckUpHeader/Create');

      var headers = {'Content-Type': 'application/json'};

      //set list
      CreateCheckupHeader create = new CreateCheckupHeader();
      if (trailerPlateController.text.isEmpty) {
        setState(() {
          create.createdBy = 'Admin';
          create.driverID = truckPlate!.driverID;
          create.truckID = truckPlate!.truckID;
          create.truckPlate = truckPlate!.truckPlate;
          create.truckType = truckPlate!.truckType;
          create.trailerID = null;
          create.trailerPlate = null;
          create.trailerType = null;
        });
      } else {
        setState(() {
          create.createdBy = 'Admin';
          create.driverID = truckPlate!.driverID;
          create.truckID = truckPlate!.truckID;
          create.truckPlate = truckPlate!.truckPlate;
          create.truckType = truckPlate!.truckType;
          create.trailerID = trailerPlate!.truckID;
          create.trailerPlate = trailerPlate!.truckPlate;
          create.trailerType = trailerPlate!.truckType;
        });
      }

      var jsonBody = jsonEncode(create);
      final encoding = Encoding.getByName('utf-8');

      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      var data = json.decode(response.body);
      CheckUpHeaderClass checkHeader = CheckUpHeaderClass.fromJson(data);

      if (response.statusCode == 200) {
        setState(() {
          prefs.setInt('checkupHeaderID', checkHeader.checkUpHeaderID);
        });
        if (checkHeader.truckType == 'Truck') {
          if (trailerPlateController.text.isEmpty) {
            setState(() {
              prefs.setInt('typeCheckUp', 2);
            });
          } else {
            setState(() {
              prefs.setInt('typeCheckUp', 3);
            });
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckupItemBulkHeadPage()));
        } else {
          setState(() {
            prefs.setInt('typeCheckUp', 1);
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CheckupItemPage()));
        }
      } else {
        showErrorDialog('Https Error createHeader');
      }
    } catch (e) {
      print("Error occured while createHeader");
    }
  }

  Future<void> backButton() async {
    setState(() {
      truckPlate = null;
      trailerPlate = null;
      truckPlateController.text = "";
      trailerPlateController.text = "";
      truckTypeController.text = "";
      listdriver = [];
      showDetail = false;
      backEnable = false;
      searchEnable = true;
      nextEnable = false;
      truckPlateColor = Color(0xFFFFFFFF);
      truckPlateReadonly = false;
      trailerPlateColor = Color(0xFFFFFFFF);
      trailerPlateReadonly = false;
      truckTypeColor = Color(0xFFFFFFFF);
      truckTypeReadonly = false;
      selectedValue = "";
    });
  }

  Future<void> searchButton() async {
    if (truckPlateController.text.isEmpty) {
      showErrorDialog('Please Enter License Head!');
      return;
    }
    await validateTruckPlate();
  }

  Future<void> nextButton() async {
    await checkHeader();
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
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment:
                    CrossAxisAlignment.center, //Center Row contents vertically,
                children: <Widget>[
                  new SizedBox(
                      width: 160.0,
                      height: 75.0,
                      child: TextFormField(
                        readOnly: truckPlateReadonly,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value) {},
                        decoration: InputDecoration(
                          fillColor: truckPlateColor,
                          filled: true,
                          hintText: 'Enter Truck Plate',
                          labelText: 'Truck Plate',
                          border: OutlineInputBorder(),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(16), //
                        ),
                        controller: truckPlateController,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment:
                    CrossAxisAlignment.center, //Center Row contents vertically,
                children: <Widget>[
                  new SizedBox(
                      width: 160.0,
                      height: 75.0,
                      child: TextFormField(
                        readOnly: trailerPlateReadonly,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value) {},
                        decoration: InputDecoration(
                          fillColor: trailerPlateColor,
                          filled: true,
                          hintText: 'Enter Trailer Plate',
                          labelText: 'Trailer Plate',
                          border: OutlineInputBorder(),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(16), //
                        ),
                        controller: trailerPlateController,
                      )),
                ],
              ),
              Visibility(
                  visible: showDetail,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, //Center Row contents vertically,
                    children: <Widget>[
                      new SizedBox(
                        width: 160.0,
                        height: 75.0,
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          value: selectedValue,
                          isExpanded: true,
                          hint: const Text(
                            'Select Driver',
                            style: TextStyle(fontSize: 14),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 60,
                          buttonPadding:
                              const EdgeInsets.only(left: 20, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          items: listdriver
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Select Driver';
                            }
                          },
                          onChanged: (value) {
                            selectedValue = value.toString();
                          },
                          onSaved: (value) {},
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: showDetail,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, //Center Row contents vertically,
                    children: <Widget>[
                      new SizedBox(
                          width: 160.0,
                          height: 75.0,
                          child: TextFormField(
                            readOnly: truckTypeReadonly,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (value) {},
                            decoration: InputDecoration(
                              fillColor: truckTypeColor,
                              filled: true,
                              hintText: 'Enter Trucktype',
                              labelText: 'Trucktype',
                              border: OutlineInputBorder(),
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.all(16), //
                            ),
                            controller: truckTypeController,
                          )),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment:
                    CrossAxisAlignment.center, //Center Row contents vertically,
                children: <Widget>[
                  Visibility(
                      visible: showDetail,
                      child: new RaisedButton(
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
                      )),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Visibility(
                      visible: !showDetail,
                      child: new RaisedButton(
                        color: searchEnable == true ? Colors.blue : Colors.grey,
                        child: const Text('Search',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: searchEnable
                            ? () async {
                                await searchButton();
                              }
                            : null,
                      )),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Visibility(
                      visible: showDetail,
                      child: new RaisedButton(
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
                      )),
                ],
              ),
            ],
          )),
        )));
  }
}
