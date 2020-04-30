import 'package:InStockOrOutOfStock/custom-widgets/near-you-tab.dart';
import 'package:InStockOrOutOfStock/custom-widgets/popular-tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../router.dart' as router;
import 'package:InStockOrOutOfStock/util/constants.dart' as Constants;
import 'package:InStockOrOutOfStock/custom-widgets/tab-widget.dart';
import '../custom-widgets/custom-drawer.dart';
import '../custom-widgets/custom-app-bar.dart';

class HomeView extends StatefulWidget {
  final String isUserLoggedIn;
  HomeView({Key key, this.isUserLoggedIn}) : super(key: key);
  _HomeViewState createState() => new _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    NearYouTab(),
    PopularTab(),
    PopularTab()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var loginStatus;
    (widget.isUserLoggedIn == null)
        ? loginStatus = Constants.LOGIN
        : loginStatus = Constants.LOGOUT;
    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: CustomDrawer(),
      body: Column(
        children: <Widget>[
          Padding(
    padding: EdgeInsets.all(16.0)),
    Padding(
    padding: EdgeInsets.only(left:30.0)),
          TextField(
        decoration: InputDecoration(
          filled: true,
          //fillColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
      ),
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          )
        ],
      ),
      // body: Container(
      //     padding: EdgeInsets.all(10),
      //     child: _widgetOptions.elementAt(_selectedIndex)
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            title: Text('Near Me'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Popular'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
