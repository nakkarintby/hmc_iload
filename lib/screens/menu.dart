import 'package:flutter/material.dart';
import 'package:test/components/menu_list.dart';
import 'package:test/screens/menu_gi.dart';
import 'package:test/screens/menu_gr.dart';
import 'package:test/screens/menu_takephoto.dart';
import 'package:test/screens/menu_transfer.dart';
import 'package:test/screens/stock_overview.dart';
import 'package:test/screens/before.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: new DecorationImage(
          image: new AssetImage("assets/Background.jpg"),
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
              MenuList(
                text: "GR",
                icon: Icon(
                  Icons.flight_land_rounded,
                  size: 40,
                  color: Colors.blue,
                ),
                press: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MenuGR()))
                },
              ),
              MenuList(
                text: "GI",
                icon: Icon(
                  Icons.flight_takeoff_rounded,
                  size: 40,
                  color: Colors.blue,
                ),
                press: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MenuGI()))
                },
              ),
              MenuList(
                text: "Transfer",
                icon: Icon(
                  Icons.swap_horiz_outlined,
                  size: 40,
                  color: Colors.blue,
                ),
                press: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MenuTransfer()))
                },
              ),
              MenuList(
                text: "Stock",
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  size: 40,
                  color: Colors.blue,
                ),
                press: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockOverviewPage()))
                },
              ),
              MenuList(
                text: "Take Photo",
                icon: Icon(
                  Icons.camera_alt_rounded,
                  size: 40,
                  color: Colors.blue,
                ),
                press: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MenuTakePhoto()))
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
