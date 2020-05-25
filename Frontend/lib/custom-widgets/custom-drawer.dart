import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/appcolor.dart';
import '../router.dart' as router;
import '../util/globals.dart';
import '../util/constants.dart' as Constants;

class CustomDrawer extends StatefulWidget {
  final chosenBackGroundColor = Color.fromRGBO(35, 44, 77, 1);
  final chosenTextColour = Color.fromRGBO(133, 201, 255, 1);
  bool  isUserLoggedIn = App.localStorage.getBool(Constants.ISLOGGED) ?? false;

  @override
  _CustomDrawerState createState() => new _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  @override
  Widget build(BuildContext context) {
    var loggedIn = widget.isUserLoggedIn;
    return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColor
                .primaryDarkColor, //This will change the drawer background to blue.
            //other styles
          ),
          child: Container(
            width: 180,
            child: new Drawer(
              elevation: 0.0,
              child: Container(
                color: AppColor.primaryDarkColor,
                padding: EdgeInsets.only(left: 50, top: 40),
                child: new ListView(
                  children: <Widget>[
                    new InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        size: 50,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(left: 40, top: 120)),
                    new Container(
                      child: new ListTile(
                        title: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                this.context, router.HOME);
                          },
                          child: new Text(
                            "Home",
                            style: TextStyle(
                                fontSize: 22,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      child: new ListTile(
                        title: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                this.context, router.ABOUT_US);
                          },
                          child: new Text(
                            "About Us",
                            style: TextStyle(
                                fontSize: 22,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    loggedIn ? getLoggedInSection() : getNonLoggedInSection(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget getNonLoggedInSection() {
    return new Container(
      child: new ListTile(
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(this.context, router.LOGIN);
          },
          child: new Text(
            "Login",
            style: TextStyle(
                fontSize: 22,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget getLoggedInSection() {
    return new Column(
      children: <Widget>[
        new Container(
          child: new ListTile(
            title: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(this.context, router.PROFILE_VIEW, arguments: widget.isUserLoggedIn);
              },
              child: new Text(
                "Profile",
                style: TextStyle(
                    fontSize: 22,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        new Container(
          child: new ListTile(
            title: GestureDetector(
              onTap: () {
//                App.localStorage.remove(Constants.ISLOGGED);
                App.localStorage.clear();
                Navigator.pushReplacementNamed(this.context, router.HOME);
              },
              child: new Text(
                "Logout",
                style: TextStyle(
                    fontSize: 22,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}
