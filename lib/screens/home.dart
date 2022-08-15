import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static String routeName = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            constraints: BoxConstraints.expand(),
            alignment: Alignment.center,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          // alignment: Alignment.center, //<--must not uncomment this
                          padding: const EdgeInsets.all(25),
                          //color: Colors.red,
                          child: Image.asset(
                            'assets/RTLS-logo.png',
                            height: MediaQuery.of(context).size.height * .15,
                            width: MediaQuery.of(context).size.width * .75,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    /* Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          // alignment: Alignment.center, //<--must not uncomment this
                          padding: const EdgeInsets.all(25),
                          //color: Colors.red,
                          child: Text(
                            "RTLS",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),*/
                    Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          // alignment: Alignment.center, //<--must not uncomment this
                          padding: const EdgeInsets.all(5),
                          //color: Colors.red,
                          child: Text(
                            "",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Logo bar

                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(alignment: Alignment.center, children: [
                          Image.asset("assets/map.png",
                              color: Color(0xff373737)),
                        ])),

                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 4),
                          color: Colors.blueAccent[350],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          color: Colors.blueGrey[300],
                          iconSize: 50,
                          icon: Icon(Icons.security),
                          onPressed: () {
                            print('a');
                          },
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
