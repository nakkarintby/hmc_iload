import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test/components/menu_list2.dart';
import 'package:test/screens/container_number.dart';
import 'package:test/screens/container_pickup.dart';
import 'package:test/screens/loading.dart';
import 'package:test/screens/ocr.dart';
import 'package:test/screens/unloading.dart';

class MenuTransport extends StatefulWidget {
  static String routeName = "/menutransport";
  @override
  _MenuTransportPageState createState() => _MenuTransportPageState();
}

class _MenuTransportPageState extends State<MenuTransport> {
  bool loadingVisible = true;
  bool unloadingVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: new DecorationImage(
          image: new AssetImage("assets/hmc_background6.jpeg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5), BlendMode.dstATop),
        )),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              SizedBox(height: 10),
              Visibility(
                visible: loadingVisible,
                child: MenuList2(
                  text: "Loading",
                  imageIcon: ImageIcon(
                    AssetImage('assets/loading.png'),
                    size: 45,
                    color: Colors.blue,
                  ),
                  press: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Loading()))
                  },
                ),
              ),
              Visibility(
                visible: unloadingVisible,
                child: MenuList2(
                  text: "Unloading",
                  imageIcon: ImageIcon(
                    AssetImage('assets/unloading.png'),
                    size: 45,
                    color: Colors.blue,
                  ),
                  press: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Unloading()))
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
