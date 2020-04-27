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
  @override
  Widget build(BuildContext context) {
    var loginStatus;
    (widget.isUserLoggedIn == null)
        ? loginStatus = Constants.LOGIN
        : loginStatus = Constants.LOGOUT;
    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: CustomDrawer(),
      body: Container(
          padding: EdgeInsets.all(10),
          child: TabWidget()
      ),
    );
  }
}

