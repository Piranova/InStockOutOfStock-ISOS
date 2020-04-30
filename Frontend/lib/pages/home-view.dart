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
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var loginStatus;
    (widget.isUserLoggedIn == null)
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
                          Text("Welcome!", textScaleFactor: 2.0, textAlign: TextAlign.start),
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

