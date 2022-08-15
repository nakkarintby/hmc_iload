import 'package:flutter/material.dart';
import 'package:test/screens/notification.dart';
import 'package:test/screens/profile2.dart';

import 'home.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/mainscreen";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController = PageController();
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          Profile2(),
          Home(),
          Notifications(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).primaryColor,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Theme.of(context).accentColor,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.grey[500]),
              ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          // <-- This works for fixed
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.shade600,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              title: Container(height: 0.0),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
