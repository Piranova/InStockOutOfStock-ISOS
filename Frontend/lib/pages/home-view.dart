import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../router.dart' as router;
import 'package:InStockOrOutOfStock/util/constants.dart' as Constants;
import 'package:InStockOrOutOfStock/custom-widgets/tab-widget.dart';

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
      appBar: AppBar(
        title: Text(Constants.HOME),
        actions: <Widget>[
          FlatButton(
            child: Text(loginStatus),
            onPressed: () {
              Navigator.pushReplacementNamed(this.context, router.LOGIN);
            },
          ),
          FlatButton(
            child: Text(Constants.CONTACT_US),
            onPressed: () {
              Navigator.pushReplacementNamed(this.context, router.LOGIN);
            },
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: TabWidget()
      ),
    );
  }
}

