import 'package:flutter/material.dart';
import 'package:test/components/menu_list2.dart';
import 'package:test/screens/checkup_item.dart';
import 'package:test/screens/package_takephoto.dart';

class Menu extends StatefulWidget {
  static String routeName = "/menu";
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<Menu> {
  bool containerVisible = true;

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
                  text: "ตรวจสอบสภาพอุปกรณ์",
                  imageIcon: ImageIcon(
                    AssetImage('assets/checksheet.png'),
                    size: 45,
                    color: Colors.blue,
                  ),
                  press: () => {},
                ),
              ),
              Visibility(
                visible: containerVisible,
                child: MenuList2(
                  text: "ถ่ายภาพการบรรจุสินค้า",
                  imageIcon: ImageIcon(
                    AssetImage('assets/camera.png'),
                    size: 45,
                    color: Colors.blue,
                  ),
                  press: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PackageTakephoto()))
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
