import 'package:flutter/material.dart';
import 'package:test/components/menu_list.dart';
import 'package:test/screens/bin_to_bin.dart';
import 'package:test/screens/damage.dart';
import 'package:test/screens/re_label.dart';
import 'package:test/screens/split.dart';

class MenuTransfer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'Transfer',
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
                text: "Bin to Bin",
                icon: Icon(
                  Icons.swap_vert_rounded,
                  size: 40,
                  color: Colors.blue,
                ),
                press: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BinToBin()))
                },
              ),
              MenuList(
                text: "ReLabel",
                icon: Icon(
                  Icons.content_copy_rounded,
                  size: 40,
                  color: Colors.blue,
                ),
                press: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReLabel()))
                },
              ),
              MenuList(
                text: "Split",
                icon: Icon(
                  Icons.splitscreen_rounded,
                  size: 40,
                  color: Colors.blue,
                ),
                press: () => {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Split()))
                },
              ),
              MenuList(
                text: "Damage",
                icon: Icon(
                  Icons.do_disturb_alt_rounded,
                  size: 40,
                  color: Colors.blue,
                ),
                press: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Damage()))
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
