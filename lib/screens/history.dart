import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/class/resvalidatepalletitem.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var session = FlutterSession();
  int isDocumentId = 0;
  String documentId = "";

  String isAppbar = "";
  String appBar = "";

  late ResValidatePalletitem? resultValPalletCheckCancel;
  late Palletitem? resultPalletCheckCancel;
  late List<Palletitem> listHistoryPalletitem = [];
  TextEditingController gradeCancelHistory = TextEditingController();
  bool gradeCancelHistoryVisible = true;
  bool gradeCancelHistoryReadonly = false;
  Color gradeCancelHistoryColor = Color(0xFFFFFFFF);
  bool cancelHistoryEnabled = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    onload();
  }

  Future<void> onload() async {
    isDocumentId = await FlutterSession().get("token_documentID");
    isAppbar =
        await FlutterSession().get("token_historyAppBarSession") + 'History';
    setState(() {
      documentId = isDocumentId.toString();
      appBar = isAppbar;
    });
    var url = Uri.parse(
        'http://192.168.1.49:8111/api/api/palletitem/getbydoc/' + documentId);
    http.Response response = await http.get(url);
    //var data = json.decode(response.body) as List;
    setState(() {
      listHistoryPalletitem = (json.decode(response.body) as List)
          .map((data) => Palletitem.fromJson(data))
          .toList();
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

  Future<void> gradeCancelCheck() async {
    String gradeInputCancle = gradeCancelHistory.text;

    var url = Uri.parse(
        'http://192.168.1.49:8111/api/api/palletitem/validatecancel/' +
            documentId +
            '/' +
            gradeInputCancle);
    http.Response response = await http.get(url);
    var data = json.decode(response.body);

    setState(() {
      resultValPalletCheckCancel = ResValidatePalletitem.fromJson(data);
      resultPalletCheckCancel = resultValPalletCheckCancel?.palletitem;
    });

    if (resultPalletCheckCancel == null) {
      showErrorDialog(resultValPalletCheckCancel!.errorMsg.toString());
    } else {
      setState(() {
        gradeCancelHistoryReadonly = true;
        gradeCancelHistoryColor = Color(0xFFEEEEEE);
        gradeCancelHistory.text = gradeInputCancle;
        cancelHistoryEnabled = true;
      });
    }
  }

  Future<void> cancelHistory() async {
    resultPalletCheckCancel!.isDeleted = true;
    String tempAPI =
        'http://192.168.1.49:8111/api/api/palletitem/updateandpost/';
    final uri = Uri.parse(tempAPI);
    final headers = {'Content-Type': 'application/json'};
    var jsonBody = jsonEncode(resultPalletCheckCancel?.toJson());
    final encoding = Encoding.getByName('utf-8');
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    var data = json.decode(response.body);
    setState(() {
      resultPalletCheckCancel = Palletitem.fromJson(data);
      gradeCancelHistoryReadonly = false;
      gradeCancelHistoryColor = Color(0xFFFFFFFF);
      gradeCancelHistory.text = '';
      cancelHistoryEnabled = false;
    });

    showSuccessDialog('Cancel Order Complete');
    onload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(color: Colors.black),
            backgroundColor: Colors.white,
            title: Text(
              isAppbar.toString(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
        body: Container(
            child: SingleChildScrollView(
                child: Form(
                    child: Column(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow[900],
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: Text('No'),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow[900],
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: Text('lot'),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow[900],
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: Text('weight'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                for (var data in listHistoryPalletitem)
                  buildHistoryRow(
                      '${data.palletNo}', '${data.lot}', '${data.weight}'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 12),
                      Container(height: 2, color: Colors.redAccent),
                      SizedBox(height: 9),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    padding: new EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 8,
                        right: MediaQuery.of(context).size.width / 8),
                    child: Visibility(
                        visible: gradeCancelHistoryVisible,
                        child: TextFormField(
                          readOnly: gradeCancelHistoryReadonly,
                          textInputAction: TextInputAction.go,
                          onFieldSubmitted: (value) {
                            gradeCancelCheck();
                          },
                          decoration: InputDecoration(
                            //icon: const Icon(Icons.person),
                            fillColor: gradeCancelHistoryColor,
                            filled: true,
                            hintText: 'Enter Grade Label Cancel',
                            labelText: 'GradeLabelCancel',
                            border: OutlineInputBorder(),
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(15), //
                          ),
                          controller: gradeCancelHistory,
                        ))),
                SizedBox(height: 20),
                new Center(
                  child: new ButtonBar(
                    mainAxisSize: MainAxisSize
                        .min, // this will take space as minimum as posible(to center)
                    children: <Widget>[
                      new RaisedButton(
                        color: Colors.redAccent,
                        child: const Text('Cancel',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: cancelHistoryEnabled
                            ? () {
                                cancelHistory();
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ])))));
  }
}

Widget buildHistoryRow(String palletNo, String lot, String weight) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
    child: Column(
      children: <Widget>[
        SizedBox(height: 12),
        Container(height: 2, color: Colors.redAccent),
        SizedBox(height: 12),
        Row(
          children: <Widget>[
            //CircleAvatar(backgroundImage: AssetImage(imageAsset)),
            SizedBox(width: 20),
            Text(palletNo),
            Spacer(),
            SizedBox(width: 10),
            Text(lot),
            Spacer(),
            Text(weight),
            SizedBox(width: 20),
          ],
        ),
      ],
    ),
  );
}
