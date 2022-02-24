import 'package:flutter/material.dart';
import 'package:test/components/menu_list.dart';
import 'package:test/screens/goods_received.dart';
import 'package:test/screens/re_goods_recived.dart';

class MenuGR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'GR',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontSize: 20),
          )),
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
              MenuList(
                text: "GoodsReceived",
                icon: Icon(
                  Icons.flight_land_rounded,
                  size: 40,
                  color: Colors.blue,
                ),
                press: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GoodReceived()))
                },
              ),
              MenuList(
                text: "Repack GR",
                icon: Icon(
                  Icons.loop_rounded,
                  size: 40,
                  color: Colors.blue,
                ),
                press: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReGoodReceived()))
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
