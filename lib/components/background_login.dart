import 'package:flutter/material.dart';

class Background_Login extends StatelessWidget {
  final Widget child;

  const Background_Login({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/top1.png", width: size.width),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/top2.png", width: size.width),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 4.7,
            right: MediaQuery.of(context).size.width / 3.3,
            child: Image.asset("assets/SMC_logo.png", width: size.width * 0.58),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/bottom1.png", width: size.width),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/bottom2.png", width: size.width),
          ),
          child
        ],
      ),
    );
  }
}
