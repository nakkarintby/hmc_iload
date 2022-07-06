import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:test/components/home_tab1.dart';
import 'package:test/components/home_tab2.dart';
import 'package:test/components/home_tab3.dart';
import 'package:test/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _activeIndex = 0;
  int _activeIndex2 = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _activeIndex = _tabController.index;
        });
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            bottom: TabBar(
              controller: _tabController,
              labelColor: Color(0xFF62A6E9),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              labelStyle: TextStyle(fontSize: 13.0),
              tabs: [
                Tab(
                  icon: _activeIndex == 0
                      ? Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                          size: 30,
                        )
                      : Icon(
                          Icons.favorite_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                ),
                Tab(
                  icon: _activeIndex == 1
                      ? Icon(
                          Icons.umbrella_rounded,
                          color: Colors.green,
                          size: 30,
                        )
                      : Icon(
                          Icons.umbrella_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                ),
                Tab(
                  icon: _activeIndex == 2
                      ? Icon(
                          Icons.audiotrack_rounded,
                          color: Colors.yellow,
                          size: 30,
                        )
                      : Icon(
                          Icons.audiotrack_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                ),
              ],
            ),
            backgroundColor: whiteColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/SMC_logo.png',
                  fit: BoxFit.contain,
                  height: 350,
                  width: 140,
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              HomeTab1(),
              HomeTab2(),
              HomeTab3(),
            ],
          ),
        ),
      ),
    );
  }
}
