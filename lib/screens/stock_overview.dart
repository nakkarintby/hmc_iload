import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'package:test/class/stockoverview.dart';
import 'package:test/mywidget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StockOverviewPage extends StatefulWidget {
  @override
  _StockOverviewPage createState() => _StockOverviewPage();
}

class _StockOverviewPage extends State<StockOverviewPage> {
  var session = FlutterSession();
  var username = "";
  int stepflow = 0;
  int step = 0;
  List<StockOView> datalist = <StockOView>[];

  TextEditingController locationController = TextEditingController();

  late StockOView? resValidateStockOverview;
  late Timer timer;
  late List<FocusNode> focusNodes = List.generate(1, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    setState(() {
      step = 0;
    });
    setFocus();
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

  void setFocus() {
    if (step == 0) {
      Future.delayed(Duration(milliseconds: 100))
          .then((_) => FocusScope.of(context).requestFocus(focusNodes[0]));
    }
  }

  Future<void> searchStock() async {
    try {
      var value = locationController.text.trim();

      if (value.length == 0) {
        //MyWidget.showMyAlertDialog(context, "Error", "Invalid Input");
        showErrorDialog("Invalid Input");
        return;
      }

      var url = Uri.parse(
          'http://192.168.1.49:8111/api/api//viewstockoverviewpage/getbybin/' +
              value);
      http.Response response = await http.get(url);
      //var data = json.decode(response.body);

      setState(() {
        Iterable data = json.decode(response.body);
        datalist = List<StockOView>.from(
            data.map((model) => StockOView.fromJson(model)));

        if (datalist.length == 0) {
          //MyWidget.showMyAlertDialog(context, "Error", "Data not found");
          showErrorDialog('Data not found');
        }
      });
    } catch (e) {
      //MyWidget.showMyAlertDialog(
      //context, "Error", e.toString() + "#E10 Server cannot be connected");
      showErrorDialog(e.toString() + "#E10 Server cannot be connected");
    }
  }

  SfDataGrid _createDataTable() {
    return SfDataGrid(
      source: TabelDataSource(datalist),
      columns: _createColumns(),
      columnWidthMode: ColumnWidthMode.auto,
    );
  }

  List<GridColumn> _createColumns() {
    return [
      createGridColumn('Material', 'material'),
      createGridColumn('Lot', 'lot'),
      createGridColumn('Weight', 'weight'),
      createGridColumn('Qty', 'qty'),
      createGridColumn('Unit', 'unit'),
    ];
  }

  GridColumn createGridColumn(String displayname, String name) {
    return GridColumn(
        columnName: name,
        label: Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: Text(displayname)));
  }

  bool StepControl(String field) {
    switch (stepflow) {
      case 0:
        {
          switch (field) {
            case "location":
              return true;
          }
        }
        break;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //double width = size.width * 0.98;
    double height = size.height * 0.70;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            leading: BackButton(color: Colors.black),
            backgroundColor: Colors.white,
            title: Text(
              'Stock OverView',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
        body: Container(
            child: SingleChildScrollView(
                child: Form(
                    child: Center(
                        child: Column(children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
              padding: new EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 5,
                  right: MediaQuery.of(context).size.width / 5),
              child: Visibility(
                  child: TextFormField(
                focusNode: focusNodes[0],
                textInputAction: TextInputAction.go,
                onFieldSubmitted: (value) {
                  searchStock();
                },
                decoration: InputDecoration(
                  //icon: const Icon(Icons.person),
                  fillColor: Color(0xFFFFFFFF),
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
            height: 20,
          ),
          Card(
            child: datalist.length > 0
                ? Container(
                    height: height,
                    child: _createDataTable(),
                  )
                : null,
          )
        ]))))));
  }
}

class Header extends StatelessWidget {
  String label;
  TextEditingController controller;
  int stepflow;
  bool isenabled;
  final VoidCallback callback;

  Header(this.label, this.controller, this.stepflow, this.isenabled,
      BuildContext context, this.callback) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      MyRowFlex(
          10,
          false,
          false,
          TextFormField(
              key: UniqueKey(),
              controller: controller,
              enabled: isenabled,
              autofocus: stepflow > 0 ? isenabled : false,
              onFieldSubmitted: (value) => callback(),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: label,
                prefixIcon:
                    Icon(Icons.location_city_outlined, color: smcBaseTheme1),
                suffixIcon: Container(
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        VerticalDivider(),
                        MyIconButton(Icon(Icons.search), callback),
                      ],
                    ),
                  ),
                ),
              ))),
    ]);
  }
}

class Content extends StatelessWidget {
  String label;
  TextEditingController controller;
  int? weight;
  IconData icondata;
  int stepflow;
  bool isenabled;
  final VoidCallback callback;

  Content(this.label, this.controller, this.weight, this.icondata,
      this.stepflow, this.isenabled, this.callback);

  @override
  Widget build(BuildContext context) {
    var statusicon = Icon(icondata);
    var weightval = null;

    if (weight != null) {
      weightval = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("weight: " + weight.toString(),
                style: TextStyle(color: Colors.grey))
          ]);
    }

    if (controller.text != "") {
      statusicon = Icon(icondata, color: smcBaseTheme1);
    }

    return Row(children: <Widget>[
      MyRowFlex(
          10,
          false,
          false,
          TextFormField(
              key: UniqueKey(),
              controller: controller,
              enabled: isenabled,
              autofocus: isenabled,
              onFieldSubmitted: (value) => callback(),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: label,
                prefixIcon: Container(
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        statusicon,
                      ],
                    ),
                  ),
                ),
                suffixIcon: Container(
                  child: IntrinsicHeight(
                    child: weightval,
                  ),
                ),
              ))),
    ]);
  }
}

class TabelDataSource extends DataGridSource {
  List<DataGridRow> _items = [];

  TabelDataSource(List<StockOView> items) {
    _items = items
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'material', value: e.materialName),
              DataGridCell<String>(columnName: 'lot', value: e.lot),
              DataGridCell<double>(columnName: 'weight', value: e.weight),
              DataGridCell<int>(columnName: 'qty', value: e.qty),
              DataGridCell<String>(columnName: 'unit', value: e.aUnit),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _items;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'unit'
            ? Alignment.center
            : dataGridCell.columnName == 'weight' ||
                    dataGridCell.columnName == 'qty'
                ? Alignment.centerRight
                : Alignment.centerLeft),
        padding: EdgeInsets.all(5),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
