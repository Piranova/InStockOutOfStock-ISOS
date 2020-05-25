import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../router.dart' as router;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:InStockOrOutOfStock/util/constants.dart' as Constants;
import 'package:InStockOrOutOfStock/custom-widgets/tab-widget.dart';
import '../custom-widgets/custom-drawer.dart';
import '../custom-widgets/custom-app-bar.dart';
import '../models/user-model.dart';
import '../util/globals.dart';
import 'dart:async';


class HomeView extends StatefulWidget {
  final bool isUserLoggedIn;
  HomeView({Key key, this.isUserLoggedIn}) : super(key: key);
  _HomeViewState createState() => new _HomeViewState();

}

class _HomeViewState extends State<HomeView> {
  var scrollController = ScrollController();

  String name = '';
  SharedPreferences prefs;

  @override
  void initState() {

    setData()
    .then((value) {
      print("completed");
      setState(() {
        name = prefs.getString('name') ?? '';
      });
    });
  }

  Future<void> setData() async {
     prefs = App.localStorage;
     var response;
    name = prefs.getString('name') ?? '';

    if(prefs.getBool(Constants.ISLOGGED)) {
      if ((prefs.getString('name') == null || prefs.getString('name').isEmpty) && prefs.getString('email') != null) {
         response = await http.get(App.url + 'profile?email=' + prefs.getString('email'));
         print("response is : " + response.statusCode.toString() + " " +
                response.body.toString());
         var jsonResponse = json.decode(response.body);
         if (response.statusCode == 200) {
          var status = jsonResponse['result'];
          var user = jsonResponse['user'];
          prefs.setString('name', user['name']);
          name = user['name'];
          prefs.setInt('user_id', user['user_id']);
        }

        return true;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var loginStatus;

    (widget.isUserLoggedIn == true)
        ? loginStatus = Constants.LOGIN
        : loginStatus = Constants.LOGOUT;
    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: CustomDrawer(),
      body: NestedScrollView(
        physics: ScrollPhysics(parent: PageScrollPhysics()),
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                  [
                    Column(
//                        margin: EdgeInsets.only(top: 150),
//                        height: 300, color: Colors.blue,
                        children: [
                          Text("Welcome " + name  + "!", textScaleFactor: 2.0, textAlign: TextAlign.start),
                          Text("What are you looking for?"),
                          
                          Container(
                            width: 286,
                            height: 51,
                            margin: EdgeInsets.all(10.0),
                            child: TextField(
                              onTap: () { print("hi");},
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 260.0),
                                    child: Icon(Icons.pin_drop, color: Colors.black)
                                  )
                                )
                            ),
                          ),
                          Container(
                            width: 286,
                            height: 51,
                            margin: EdgeInsets.all(10.0),
                            child: TextField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
                                  ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 260.0),
                                        child: Icon(Icons.zoom_out, color: Colors.black)
                                    )
                                )
                            ),
                          ),
                          ],
                    )
                  ]),
            ),
          ];
        },
        body: TabWidget()
        ),
      );
  }
}

