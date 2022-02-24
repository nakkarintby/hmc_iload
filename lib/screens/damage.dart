import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/class/documentitem.dart';
import 'package:test/class/resvalidatedocument.dart';
import 'package:test/class/resvalidatelocation.dart';
import 'package:test/class/resvalidatepalletitem.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:test/mywidget.dart';
import 'package:test/screens/history.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

class Damage extends StatefulWidget {
  const Damage({Key? key}) : super(key: key);

  @override
  _DamageState createState() => _DamageState();
}

class _DamageState extends State<Damage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController documentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController gradeLabel1Controller = TextEditingController();
  TextEditingController weight1Controller = TextEditingController();
  TextEditingController gradeLabel2Controller = TextEditingController();
  TextEditingController weight2Controller = TextEditingController();
  TextEditingController gradeLabel3Controller = TextEditingController();
  TextEditingController weight3Controller = TextEditingController();

  bool documentVisible = false;
  bool locationVisible = false;
  bool gradeLabel1Visible = false;
  bool weight1Visible = false;
  bool gradeLabel2Visible = false;
  bool weight2Visible = false;
  bool gradeLabel3Visible = false;
  bool weight3Visible = false;

  bool documentReadonly = false;
  bool locationReadonly = false;
  bool gradeLabel1Readonly = false;
  bool weight1Readonly = false;
  bool gradeLabel2Readonly = false;
  bool weight2Readonly = false;
  bool gradeLabel3Readonly = false;
  bool weight3Readonly = false;

  Color documentColor = Color(0xFFFFFFFF);
  Color locationColor = Color(0xFFFFFFFF);
  Color gradeLabel1Color = Color(0xFFFFFFFF);
  Color weight1Color = Color(0xFFFFFFFF);
  Color gradeLabel2Color = Color(0xFFFFFFFF);
  Color weight2Color = Color(0xFFFFFFFF);
  Color gradeLabel3Color = Color(0xFFFFFFFF);
  Color weight3Color = Color(0xFFFFFFFF);

  bool backEnabled = false;
  bool finishEnabled = false;

  //step
  int step = 0;
  //variable call api
  String documentIdInput = '';
  String locationInput = '';
  String gradeLabel1Input = '';
  String weight1Input = '';
  String gradeLabel2Input = '';
  String weight2Input = '';
  String gradeLabel3Input = '';
  String weight3Input = '';

  late ResValidateDocument? resultValDocument;
  late ResValidateLocation? resultValLocation;
  late ResValidatePalletitem? resultValPallet;
  late Document? resultDocument;
  late Location? resultLocation;
  late Location? resultLocationDamage;
  late Palletitem? resultPalletitem;
  late List<Palletitem?> listPalletitem = [];

  int isUsername = 0;
  String username = "";
  late List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _getSession();
    setState(() {
      step = 0;
    });
    setVisible();
    setReadOnly();
    setColor();
    setText();
  }

  _getSession() async {
    isUsername = await FlutterSession().get("token_username");
    setState(() {
      username = isUsername.toString();
    });
  }

  void setVisible() {
    if (step == 0) {
      setState(() {
        documentVisible = true;
        locationVisible = false;
        gradeLabel1Visible = false;
        weight1Visible = false;
        gradeLabel2Visible = false;
        weight2Visible = false;
        gradeLabel3Visible = false;
        weight3Visible = false;
      });
    } else if (step == 1) {
      setState(() {
        documentVisible = true;
        locationVisible = true;
        gradeLabel1Visible = false;
        weight1Visible = false;
        gradeLabel2Visible = false;
        weight2Visible = false;
        gradeLabel3Visible = false;
        weight3Visible = false;
      });
    } else if (step == 2) {
      setState(() {
        documentVisible = true;
        locationVisible = true;
        gradeLabel1Visible = true;
        weight1Visible = true;
        gradeLabel2Visible = false;
        weight2Visible = false;
        gradeLabel3Visible = false;
        weight3Visible = false;
      });
    } else if (step == 3) {
      setState(() {
        documentVisible = true;
        locationVisible = true;
        gradeLabel1Visible = true;
        weight1Visible = true;
        gradeLabel2Visible = true;
        weight2Visible = true;
        gradeLabel3Visible = false;
        weight3Visible = false;
      });
    } else if (step == 4) {
      setState(() {
        documentVisible = true;
        locationVisible = true;
        gradeLabel1Visible = true;
        weight1Visible = true;
        gradeLabel2Visible = true;
        weight2Visible = true;
        gradeLabel3Visible = true;
        weight3Visible = true;
      });
    } else if (step == 5) {
      setState(() {
        documentVisible = true;
        locationVisible = true;
        gradeLabel1Visible = true;
        weight1Visible = true;
        gradeLabel2Visible = true;
        weight2Visible = true;
        gradeLabel3Visible = true;
        weight3Visible = true;
      });
    }
  }

  void setReadOnly() {
    if (step == 0) {
      setState(() {
        documentReadonly = false;
        locationReadonly = false;
        gradeLabel1Readonly = false;
        weight1Readonly = false;
        gradeLabel2Readonly = false;
        weight2Readonly = false;
        gradeLabel3Readonly = false;
        weight3Readonly = false;

        backEnabled = false;
        finishEnabled = false;
      });
    } else if (step == 1) {
      setState(() {
        documentReadonly = true;
        locationReadonly = false;
        gradeLabel1Readonly = false;
        weight1Readonly = false;
        gradeLabel2Readonly = false;
        weight2Readonly = false;
        gradeLabel3Readonly = false;
        weight3Readonly = false;

        backEnabled = true;
        finishEnabled = false;
      });
    } else if (step == 2) {
      setState(() {
        documentReadonly = true;
        locationReadonly = true;
        gradeLabel1Readonly = false;
        weight1Readonly = true;
        gradeLabel2Readonly = false;
        weight2Readonly = false;
        gradeLabel3Readonly = false;
        weight3Readonly = false;

        backEnabled = true;
        finishEnabled = false;
      });
    } else if (step == 3) {
      setState(() {
        documentReadonly = true;
        locationReadonly = true;
        gradeLabel1Readonly = true;
        weight1Readonly = true;
        gradeLabel2Readonly = false;
        weight2Readonly = true;
        gradeLabel3Readonly = false;
        weight3Readonly = false;

        backEnabled = true;
        finishEnabled = false;
      });
    } else if (step == 4) {
      setState(() {
        documentReadonly = true;
        locationReadonly = true;
        gradeLabel1Readonly = true;
        weight1Readonly = true;
        gradeLabel2Readonly = true;
        weight2Readonly = true;
        gradeLabel3Readonly = false;
        weight3Readonly = true;

        backEnabled = true;
        finishEnabled = false;
      });
    } else if (step == 5) {
      setState(() {
        documentReadonly = true;
        locationReadonly = true;
        gradeLabel1Readonly = true;
        weight1Readonly = true;
        gradeLabel2Readonly = true;
        weight2Readonly = true;
        gradeLabel3Readonly = true;
        weight3Readonly = true;

        backEnabled = true;
        finishEnabled = true;
      });
    }
  }

  void setColor() {
    if (step == 0) {
      setState(() {
        documentColor = Color(0xFFFFFFFF);
        locationColor = Color(0xFFFFFFFF);
        gradeLabel1Color = Color(0xFFFFFFFF);
        weight1Color = Color(0xFFFFFFFF);
        gradeLabel2Color = Color(0xFFFFFFFF);
        weight2Color = Color(0xFFFFFFFF);
        gradeLabel3Color = Color(0xFFFFFFFF);
        weight3Color = Color(0xFFFFFFFF);
      });
    } else if (step == 1) {
      setState(() {
        documentColor = Color(0xFFEEEEEE);
        locationColor = Color(0xFFFFFFFF);
        gradeLabel1Color = Color(0xFFFFFFFF);
        weight1Color = Color(0xFFFFFFFF);
        gradeLabel2Color = Color(0xFFFFFFFF);
        weight2Color = Color(0xFFFFFFFF);
        gradeLabel3Color = Color(0xFFFFFFFF);
        weight3Color = Color(0xFFFFFFFF);
      });
    } else if (step == 2) {
      setState(() {
        documentColor = Color(0xFFEEEEEE);
        locationColor = Color(0xFFEEEEEE);
        gradeLabel1Color = Color(0xFFFFFFFF);
        weight1Color = Color(0xFFEEEEEE);
        gradeLabel2Color = Color(0xFFFFFFFF);
        weight2Color = Color(0xFFFFFFFF);
        gradeLabel3Color = Color(0xFFFFFFFF);
        weight3Color = Color(0xFFFFFFFF);
      });
    } else if (step == 3) {
      setState(() {
        documentColor = Color(0xFFEEEEEE);
        locationColor = Color(0xFFEEEEEE);
        gradeLabel1Color = Color(0xFFEEEEEE);
        weight1Color = Color(0xFFEEEEEE);
        gradeLabel2Color = Color(0xFFFFFFFF);
        weight2Color = Color(0xFFEEEEEE);
        gradeLabel3Color = Color(0xFFFFFFFF);
        weight3Color = Color(0xFFFFFFFF);
      });
    } else if (step == 4) {
      setState(() {
        documentColor = Color(0xFFEEEEEE);
        locationColor = Color(0xFFEEEEEE);
        gradeLabel1Color = Color(0xFFEEEEEE);
        weight1Color = Color(0xFFEEEEEE);
        gradeLabel2Color = Color(0xFFEEEEEE);
        weight2Color = Color(0xFFEEEEEE);
        gradeLabel3Color = Color(0xFFFFFFFF);
        weight3Color = Color(0xFFEEEEEE);
      });
    } else if (step == 5) {
      setState(() {
        documentColor = Color(0xFFEEEEEE);
        locationColor = Color(0xFFEEEEEE);
        gradeLabel1Color = Color(0xFFEEEEEE);
        weight1Color = Color(0xFFEEEEEE);
        gradeLabel2Color = Color(0xFFEEEEEE);
        weight2Color = Color(0xFFEEEEEE);
        gradeLabel3Color = Color(0xFFEEEEEE);
        weight3Color = Color(0xFFEEEEEE);
      });
    }
  }

  void setText() {
    if (step == 0) {
      setState(() {
        documentController.text = '';
        locationController.text = '';
        gradeLabel1Controller.text = '';
        weight1Controller.text = '';
        gradeLabel2Controller.text = '';
        weight2Controller.text = '';
        gradeLabel3Controller.text = '';
        weight3Controller.text = '';
      });
    } else if (step == 1) {
      setState(() {
        documentController.text = documentIdInput;
        locationController.text = '';
        gradeLabel1Controller.text = '';
        weight1Controller.text = '';
        gradeLabel2Controller.text = '';
        weight2Controller.text = '';
        gradeLabel3Controller.text = '';
        weight3Controller.text = '';
      });
    } else if (step == 2) {
      setState(() {
        documentController.text = documentIdInput;
        locationController.text = locationInput;
        gradeLabel1Controller.text = '';
        weight1Controller.text = '';
        gradeLabel2Controller.text = '';
        weight2Controller.text = '';
        gradeLabel3Controller.text = '';
        weight3Controller.text = '';
      });
    } else if (step == 3) {
      setState(() {
        documentController.text = documentIdInput;
        locationController.text = locationInput;
        gradeLabel1Controller.text = gradeLabel1Input;
        weight1Controller.text = weight1Input;
        gradeLabel2Controller.text = '';
        weight2Controller.text = '';
        gradeLabel3Controller.text = '';
        weight3Controller.text = '';
      });
    } else if (step == 4) {
      setState(() {
        documentController.text = documentIdInput;
        locationController.text = locationInput;
        gradeLabel1Controller.text = gradeLabel1Input;
        weight1Controller.text = weight1Input;
        gradeLabel2Controller.text = gradeLabel2Input;
        weight2Controller.text = weight2Input;
        gradeLabel3Controller.text = '';
        weight3Controller.text = '';
      });
    } else if (step == 5) {
      setState(() {
        documentController.text = documentIdInput;
        locationController.text = locationInput;
        gradeLabel1Controller.text = gradeLabel1Input;
        weight1Controller.text = weight1Input;
        gradeLabel2Controller.text = gradeLabel2Input;
        weight2Controller.text = weight2Input;
        gradeLabel3Controller.text = gradeLabel3Input;
        weight3Controller.text = weight3Input;
      });
    }
  }

  void setFocus() {
    if (step == 0) {
      Future.delayed(Duration(milliseconds: 100))
          .then((_) => FocusScope.of(context).requestFocus(focusNodes[0]));
    } else if (step == 1) {
      Future.delayed(Duration(milliseconds: 100))
          .then((_) => FocusScope.of(context).requestFocus(focusNodes[1]));
    } else if (step == 2) {
      Future.delayed(Duration(milliseconds: 100))
          .then((_) => FocusScope.of(context).requestFocus(focusNodes[2]));
    } else if (step == 3) {
      Future.delayed(Duration(milliseconds: 100))
          .then((_) => FocusScope.of(context).requestFocus(focusNodes[3]));
    } else if (step == 4) {
      Future.delayed(Duration(milliseconds: 100))
          .then((_) => FocusScope.of(context).requestFocus(focusNodes[4]));
    } else if (step == 5) {
      Future.delayed(Duration(milliseconds: 100))
          .then((_) => FocusScope.of(context).requestFocus(focusNodes[5]));
    }
  }

  void showErrorDialog(String error) {
    //MyWidget.showMyAlertDialog(context, "Error", error);
    alertDialog(error, 'Error');
  }

  void showSuccessDialog(String success) {
    //MyWidget.showMyAlertDialog(context, "Success", success);
    alertDialog(success, 'Success');
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
          timer = Timer(Duration(seconds: 2), () {
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

  Future<void> documentCheck() async {
    setState(() {
      documentIdInput = documentController.text;
    });
    var url = Uri.parse(
        'http://192.168.1.49:8111/api/api/document/validatedm/' +
            documentIdInput);
    http.Response response = await http.get(url);
    var data = json.decode(response.body);
    setState(() {
      resultValDocument = ResValidateDocument.fromJson(data);
      resultDocument = resultValDocument?.document;
    });

    if (resultDocument == null) {
      showErrorDialog(resultValDocument!.errorMsg.toString());
    } else {
      setState(() {
        step++;
      });
    }
    setVisible();
    setReadOnly();
    setColor();
    setText();
    setFocus();
  }

  Future<void> locationCheck() async {
    setState(() {
      locationInput = locationController.text;
    });
    var url = Uri.parse(
        'http://192.168.1.49:8111/api/api/location/validatedm/' +
            locationInput);
    http.Response response = await http.get(url);
    var data = json.decode(response.body);
    setState(() {
      resultValLocation = ResValidateLocation.fromJson(data);
      resultLocation = resultValLocation?.location;
    });

    var splitLocation = locationInput.split('-');
    String binLocation = splitLocation[0];
    var url2 = Uri.parse(
        'http://192.168.1.49:8111/api/api/location/validatedm/' +
            binLocation +
            "(Damage)");
    http.Response response2 = await http.get(url2);
    var data2 = json.decode(response2.body);
    setState(() {
      resultValLocation = ResValidateLocation.fromJson(data2);
      resultLocationDamage = resultValLocation?.location;
    });

    if (resultLocation == null || resultLocationDamage == null) {
      showErrorDialog(resultValLocation!.errorMsg.toString());
    } else {
      setState(() {
        step++;
      });
    }
    setVisible();
    setReadOnly();
    setColor();
    setText();
    setFocus();
  }

  Future<void> grade1Check() async {
    setState(() {
      gradeLabel1Input = gradeLabel1Controller.text;
    });

    int? temp = resultLocation?.binId;
    int locationbinIdTemp = temp!;

    var url = Uri.parse(
        'http://192.168.1.49:8111/api/api/palletitem/validatedm/' +
            resultDocument!.documentId.toString() +
            '/' +
            gradeLabel1Input +
            '/' +
            locationbinIdTemp.toString() +
            '/' +
            'From');
    http.Response response = await http.get(url);
    var data = json.decode(response.body);
    setState(() {
      resultValPallet = ResValidatePalletitem.fromJson(data);
      resultPalletitem = resultValPallet?.palletitem;
    });

    if (resultPalletitem == null) {
      showErrorDialog(resultValPallet!.errorMsg.toString());
    } else {
      setState(() {
        step++;
        resultPalletitem!.scanBy = username;
        resultPalletitem!.createdBy = username;
        resultPalletitem!.gradeLabel = gradeLabel1Input;
        weight1Input = resultPalletitem!.weight.toString();
        listPalletitem.add(resultPalletitem);
      });
    }
    setVisible();
    setReadOnly();
    setColor();
    setText();
    setFocus();
  }

  Future<void> grade2Check() async {
    setState(() {
      gradeLabel2Input = gradeLabel2Controller.text;
    });

    int? temp = resultLocation?.binId;
    int locationbinIdTemp = temp!;

    var url = Uri.parse(
        'http://192.168.1.49:8111/api/api/palletitem/validatedm/' +
            resultDocument!.documentId.toString() +
            '/' +
            gradeLabel2Input +
            '/' +
            locationbinIdTemp.toString() +
            '/' +
            'To');
    http.Response response = await http.get(url);
    var data = json.decode(response.body);
    setState(() {
      resultValPallet = ResValidatePalletitem.fromJson(data);
      resultPalletitem = resultValPallet?.palletitem;
    });

    bool gradeDuplicate = false;
    for (int i = 0; i < listPalletitem.length; i++) {
      if (listPalletitem[i]!.gradeLabel == gradeLabel2Input) {
        gradeDuplicate = true;
        break;
      }
    }

    double? temp2;
    double palletWeightTemp = 0;
    if (resultPalletitem != null) {
      temp2 = resultPalletitem?.weight;
      palletWeightTemp = temp2!;
    }

    double check311ListPalletWeight = 0;
    for (int i = 0; i < listPalletitem.length; i++) {
      if (listPalletitem[i]!.movementTypeId == 311) {
        double? temp = listPalletitem[i]?.weight;
        check311ListPalletWeight += temp!;
      }
    }

    double check312ListPalletWeight = 0;
    for (int i = 0; i < listPalletitem.length; i++) {
      if (listPalletitem[i]!.movementTypeId == 312) {
        double? temp = listPalletitem[i]?.weight;
        check312ListPalletWeight += temp!;
      }
    }
    if (resultPalletitem == null) {
      showErrorDialog(resultValPallet!.errorMsg.toString());
    } else if (gradeDuplicate) {
      showErrorDialog("#E11 GradeLabel is Duplicate");
    } else if (palletWeightTemp == check311ListPalletWeight) {
      showErrorDialog("#E12 Pallet is overweight");
    } else if (check312ListPalletWeight + palletWeightTemp >
        check311ListPalletWeight) {
      showErrorDialog("#E13 Pallet is overweight");
    } else {
      setState(() {
        step++;
        resultPalletitem!.scanBy = username;
        resultPalletitem!.createdBy = username;
        resultPalletitem!.gradeLabel = gradeLabel2Input;
        weight2Input = resultPalletitem!.weight.toString();
        listPalletitem.add(resultPalletitem);
      });
    }
    setVisible();
    setReadOnly();
    setColor();
    setText();
    setFocus();
  }

  Future<void> grade3Check() async {
    setState(() {
      gradeLabel3Input = gradeLabel3Controller.text;
    });

    int? temp = resultLocation?.binId;
    int locationbinIdTemp = temp!;

    var url = Uri.parse(
        'http://192.168.1.49:8111/api/api/palletitem/validatedm/' +
            resultDocument!.documentId.toString() +
            '/' +
            gradeLabel3Input +
            '/' +
            locationbinIdTemp.toString() +
            '/' +
            'To');
    http.Response response = await http.get(url);
    var data = json.decode(response.body);
    setState(() {
      resultValPallet = ResValidatePalletitem.fromJson(data);
      resultPalletitem = resultValPallet?.palletitem;
    });

    bool gradeDuplicate = false;
    for (int i = 0; i < listPalletitem.length; i++) {
      if (listPalletitem[i]!.gradeLabel == gradeLabel3Input) {
        gradeDuplicate = true;
        break;
      }
    }

    double? temp2;
    double palletWeightTemp = 0;
    if (resultPalletitem != null) {
      temp2 = resultPalletitem?.weight;
      palletWeightTemp = temp2!;
    }

    double check311ListPalletWeight = 0;
    for (int i = 0; i < listPalletitem.length; i++) {
      if (listPalletitem[i]!.movementTypeId == 311) {
        double? temp = listPalletitem[i]?.weight;
        check311ListPalletWeight += temp!;
      }
    }

    double check312ListPalletWeight = 0;
    for (int i = 0; i < listPalletitem.length; i++) {
      if (listPalletitem[i]!.movementTypeId == 312) {
        double? temp = listPalletitem[i]?.weight;
        check312ListPalletWeight += temp!;
      }
    }
    if (resultPalletitem == null) {
      showErrorDialog(resultValPallet!.errorMsg.toString());
    } else if (gradeDuplicate) {
      showErrorDialog("#E11 GradeLabel is Duplicate");
    } else if (palletWeightTemp == check311ListPalletWeight) {
      showErrorDialog("#E12 Pallet is overweight");
    } else if (check312ListPalletWeight + palletWeightTemp >
        check311ListPalletWeight) {
      showErrorDialog("#E13 Pallet is overweight");
    } else if (check312ListPalletWeight + palletWeightTemp !=
        check311ListPalletWeight) {
      showErrorDialog("#E14 Pallet is wrong weight");
    } else {
      setState(() {
        step++;
        resultPalletitem!.binId = resultLocationDamage!.binId;
        resultPalletitem!.scanBy = username;
        resultPalletitem!.createdBy = username;
        resultPalletitem!.gradeLabel = gradeLabel2Input;
        weight3Input = resultPalletitem!.weight.toString();
        listPalletitem.add(resultPalletitem);
      });
    }
    setVisible();
    setReadOnly();
    setColor();
    setText();
    setFocus();
  }

  Future<void> finishDamage() async {
    String tempAPI = 'http://192.168.1.49:8111/api/api/palletitem/createdamage';
    final uri = Uri.parse(tempAPI);
    final headers = {'Content-Type': 'application/json'};
    var jsonBody = jsonEncode(listPalletitem);
    final encoding = Encoding.getByName('utf-8');
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    var data = json.decode(response.body);
    bool result = data;

    resultDocument!.documentStatus = "Document Completed";
    String tempAPI2 = 'http://192.168.1.49:8111/api/api/document/update';
    final uri2 = Uri.parse(tempAPI2);
    final headers2 = {'Content-Type': 'application/json'};
    var jsonBody2 = jsonEncode(resultDocument?.toJson());
    final encoding2 = Encoding.getByName('utf-8');
    http.Response response2 = await http.post(
      uri2,
      headers: headers2,
      body: jsonBody2,
      encoding: encoding2,
    );
    var data2 = json.decode(response2.body);

    if (result) {
      showSuccessDialog('Scan Complete');

      setState(() {
        step = 0;
      });
    } else {
      showErrorDialog('Failed');
    }

    setVisible();
    setReadOnly();
    setColor();
    setText();
    setFocus();
    setState(() {
      listPalletitem.clear();
    });
  }

  void back() {
    if (step == 3 || step == 4) {
      setState(() {
        step--;
        listPalletitem.removeLast();
      });
    } else if (step == 5) {
      setState(() {
        step = step - 2;
        listPalletitem.removeLast();
        listPalletitem.removeLast();
      });
    } else {
      setState(() {
        step--;
      });
    }
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (step == 0) {
      setState(() {
        documentController.text = barcodeScanRes;
      });
      documentCheck();
    } else if (step == 1) {
      setState(() {
        locationController.text = barcodeScanRes;
      });
      locationCheck();
    } else if (step == 2) {
      setState(() {
        gradeLabel1Controller.text = barcodeScanRes;
      });
      grade1Check();
    } else if (step == 3) {
      setState(() {
        gradeLabel2Controller.text = barcodeScanRes;
      });
      grade2Check();
    } else if (step == 4) {
      setState(() {
        gradeLabel3Controller.text = barcodeScanRes;
      });
      grade3Check();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'Damage',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.black,
                ),
                onPressed: scanQR)
          ],
        ),
        body: Container(
            child: SingleChildScrollView(
                child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 36,
              ),
              Container(
                  padding: new EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 5,
                      right: MediaQuery.of(context).size.width / 5),
                  child: Visibility(
                      visible: documentVisible,
                      child: TextFormField(
                        focusNode: focusNodes[0],
                        readOnly: documentReadonly,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value) {
                          documentCheck();
                        },
                        decoration: InputDecoration(
                          //icon: const Icon(Icons.person),
                          fillColor: documentColor,
                          filled: true,
                          hintText: 'Enter Document No.',
                          labelText: 'Document No.',
                          border: OutlineInputBorder(),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(15), //
                        ),
                        controller: documentController,
                      ))),
              SizedBox(
                height: 16,
              ),
              Container(
                  padding: new EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 5,
                      right: MediaQuery.of(context).size.width / 5),
                  child: Visibility(
                      visible: locationVisible,
                      child: TextFormField(
                        focusNode: focusNodes[1],
                        readOnly: locationReadonly,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value) {
                          locationCheck();
                        },
                        decoration: InputDecoration(
                          //icon: const Icon(Icons.person),
                          fillColor: locationColor,
                          filled: true,
                          hintText: 'Enter Location',
                          labelText: 'Location',
                          border: OutlineInputBorder(),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(15), //
                        ),
                        controller: locationController,
                      ))),
              SizedBox(
                height: 16,
              ),
              Container(
                  padding: new EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 5,
                      right: MediaQuery.of(context).size.width / 5),
                  child: Visibility(
                      visible: gradeLabel1Visible,
                      child: TextFormField(
                        focusNode: focusNodes[2],
                        readOnly: gradeLabel1Readonly,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value) {
                          grade1Check();
                        },
                        decoration: InputDecoration(
                          //icon: const Icon(Icons.person),
                          fillColor: gradeLabel1Color,
                          filled: true,
                          hintText: 'Enter GradeLabel1',
                          labelText: 'GradeLabel1',
                          border: OutlineInputBorder(),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(15), //
                        ),
                        controller: gradeLabel1Controller,
                      ))),
              SizedBox(
                height: 16,
              ),
              Container(
                  padding: new EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 5,
                      right: MediaQuery.of(context).size.width / 5),
                  child: Visibility(
                      visible: weight1Visible,
                      child: TextFormField(
                        readOnly: weight1Readonly,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value) {},
                        decoration: InputDecoration(
                          //icon: const Icon(Icons.person),
                          fillColor: weight1Color,
                          filled: true,
                          hintText: 'Enter weight1',
                          labelText: 'weight1',
                          border: OutlineInputBorder(),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(15), //
                        ),
                        controller: weight1Controller,
                      ))),
              SizedBox(
                height: 16,
              ),
              Container(
                  padding: new EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 5,
                      right: MediaQuery.of(context).size.width / 5),
                  child: Visibility(
                      visible: gradeLabel2Visible,
                      child: TextFormField(
                        focusNode: focusNodes[3],
                        readOnly: gradeLabel2Readonly,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value) {
                          grade2Check();
                        },
                        decoration: InputDecoration(
                          //icon: const Icon(Icons.person),
                          fillColor: gradeLabel2Color,
                          filled: true,
                          hintText: 'Enter GradeLabel2',
                          labelText: 'GradeLabel2',
                          border: OutlineInputBorder(),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(15), //
                        ),
                        controller: gradeLabel2Controller,
                      ))),
              SizedBox(
                height: 16,
              ),
              Container(
                  padding: new EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 5,
                      right: MediaQuery.of(context).size.width / 5),
                  child: Visibility(
                      visible: weight2Visible,
                      child: TextFormField(
                        readOnly: weight2Readonly,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value) {},
                        decoration: InputDecoration(
                          //icon: const Icon(Icons.person),
                          fillColor: weight2Color,
                          filled: true,
                          hintText: 'Enter weight2',
                          labelText: 'weight2',
                          border: OutlineInputBorder(),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(15), //
                        ),
                        controller: weight2Controller,
                      ))),
              SizedBox(
                height: 16,
              ),
              Container(
                  padding: new EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 5,
                      right: MediaQuery.of(context).size.width / 5),
                  child: Visibility(
                      visible: gradeLabel3Visible,
                      child: TextFormField(
                        focusNode: focusNodes[4],
                        readOnly: gradeLabel3Readonly,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value) {
                          grade3Check();
                        },
                        decoration: InputDecoration(
                          //icon: const Icon(Icons.person),
                          fillColor: gradeLabel3Color,
                          filled: true,
                          hintText: 'Enter GradeLabel3',
                          labelText: 'GradeLabel3',
                          border: OutlineInputBorder(),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(15), //
                        ),
                        controller: gradeLabel3Controller,
                      ))),
              SizedBox(
                height: 16,
              ),
              Container(
                  padding: new EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 5,
                      right: MediaQuery.of(context).size.width / 5),
                  child: Visibility(
                      visible: weight3Visible,
                      child: TextFormField(
                        readOnly: weight3Readonly,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value) {},
                        decoration: InputDecoration(
                          //icon: const Icon(Icons.person),
                          fillColor: weight3Color,
                          filled: true,
                          hintText: 'Enter weight3',
                          labelText: 'weight3',
                          border: OutlineInputBorder(),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(15), //
                        ),
                        controller: weight3Controller,
                      ))),
              SizedBox(
                height: 16,
              ),
              new Center(
                child: new ButtonBar(
                  mainAxisSize: MainAxisSize
                      .min, // this will take space as minimum as posible(to center)
                  children: <Widget>[
                    new RaisedButton(
                      color: Colors.blue,
                      child: const Text('Back',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: backEnabled
                          ? () {
                              back();
                              setVisible();
                              setReadOnly();
                              setColor();
                              setText();
                              setFocus();
                            }
                          : null,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 20,
                    ),
                    new RaisedButton(
                      focusNode: focusNodes[5],
                      color: Colors.blue,
                      child: const Text('Finish',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: finishEnabled
                          ? () {
                              finishDamage();
                            }
                          : null,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ))));
  }
}
