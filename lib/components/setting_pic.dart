import 'package:flutter/material.dart';

class SettingPic extends StatelessWidget {
  const SettingPic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/profile.jpg"),
            radius: 50.0,
          ),
          /*CircleAvatar(
            backgroundImage: NetworkImage(
              "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
            ),
            radius: 50.0,
          ),*/
          Positioned(
            right: -8,
            bottom: 14,
            child: SizedBox(
              height: 40,
              width: 40,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  print("aaa");
                },
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.grey,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
