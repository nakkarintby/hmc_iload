import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test/components/menu_list2.dart';
import 'package:test/screens/container_number.dart';
import 'package:test/screens/container_pickup.dart';

class MenuContainer extends StatefulWidget {
  static String routeName = "/menucontainer";
  @override
  _MenuContainerPageState createState() => _MenuContainerPageState();
}

class _MenuContainerPageState extends State<MenuContainer> {
  bool containerVisible = true;
  bool ocrVisible = true;

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
                visible: containerVisible,
                child: MenuList2(
                  text: "Container Pick-up",
                  imageIcon: ImageIcon(
                    AssetImage('assets/desccon.png'),
                    size: 45,
                    color: Colors.blue,
                  ),
                  press: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContainerPickup()))
                  },
                ),
              ),
              Visibility(
                visible: ocrVisible,
                child: MenuList2(
                  text: "Container Numbers",
                  imageIcon: ImageIcon(
                    AssetImage('assets/number.png'),
                    size: 45,
                    color: Colors.blue,
                  ),
                  press: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContainerNumber()))
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
