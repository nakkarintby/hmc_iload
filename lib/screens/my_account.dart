import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(color: Colors.black),
            backgroundColor: Colors.white,
            title: Text(
              'My Account',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
        body: Container(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blueAccent, Colors.lightBlueAccent])),
                  child: Container(
                    width: double.infinity,
                    height: 350.0,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/profile.jpg"),
                            radius: 80.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          /*Text(
                            "James Rodigrez",
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),*/
                          SizedBox(
                            height: 10.0,
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 22.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "ID",
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        FutureBuilder(
                                            future: FlutterSession()
                                                .get('token_userid'),
                                            builder: (context, snapshot) {
                                              return Text(
                                                snapshot.hasData
                                                    ? snapshot.data.toString()
                                                    : 'Loading',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Username",
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        FutureBuilder(
                                            future: FlutterSession()
                                                .get('token_username'),
                                            builder: (context, snapshot) {
                                              return Text(
                                                snapshot.hasData
                                                    ? snapshot.data.toString()
                                                    : 'Loading',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Role",
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        FutureBuilder(
                                            future: FlutterSession()
                                                .get('token_role'),
                                            builder: (context, snapshot) {
                                              return Text(
                                                snapshot.hasData
                                                    ? snapshot.data.toString()
                                                    : 'Loading',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Bio:",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontStyle: FontStyle.normal,
                            fontSize: 28.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'My name is Alice and I am  a freelance mobile app developper.\n'
                        'if you need any mobile app for your company then contact me for more informations',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 300.00,
                child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    elevation: 0.0,
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Colors.blueAccent,
                              Colors.lightBlueAccent
                            ]),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Contact me",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        )));
  }
}
