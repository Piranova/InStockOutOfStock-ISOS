import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import '../custom-widgets/custom-drawer.dart';
import '../custom-widgets/custom-app-bar.dart';
import '../util/appcolor.dart';
import '../router.dart' as router;
import '../custom-widgets/tab-list-view.dart';

class ProfileView extends StatefulWidget {
  final bool isNoRequest;

  ProfileView({Key key, this.isNoRequest}) : super(key: key);

  _ProfileViewState createState() => new _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        endDrawer: CustomDrawer(),
        backgroundColor: AppColor.primaryColor,
        body: Container(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            profileUserDetailsSection(),
            Padding(padding: EdgeInsets.only(top: 40, bottom: 5)),
            profileButtonSection(),
            Padding(padding: EdgeInsets.only(top: 40, bottom: 5)),
            myRequestsLabelSection(),
            Padding(padding: EdgeInsets.only(top: 20, bottom: 5)),
            Expanded(
              child: myRequestsSection(),
            ),
          ]),
        ));
  }

  Widget profileUserDetailsSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(30, 30, 20, 5),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text("Pavan",
                style: TextStyle(
                    fontSize: 20,
                    color: AppColor.primaryDarkColor,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(30, 5, 20, 0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text("#83, Church Street, Bengaluru",
                style: TextStyle(
                    fontSize: 13,
                    color: AppColor.primaryDarkColor,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w300)),
          ),
        )
      ],
    );
  }

  Widget profileButtonSection() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 20, 5),
          child: Container(
            //alignment: Alignment.topLeft,
            child: new InkWell(
              onTap: () => editProfile(),
              child: new Container(
                width: 150.0,
                height: 50.0,
                decoration: new BoxDecoration(
                  color: AppColor.primaryDarkColor,
                  border: new Border.all(
                      color: AppColor.primaryDarkColor, width: 2.0),
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: new Center(
                  child: Row(
                    children: [
                      new Padding(padding: EdgeInsets.only(right: 10)),
                      new IconTheme(
                        data: new IconThemeData(color: AppColor.fontColor),
                        child: new Icon(Icons.supervised_user_circle),
                      ),
                      new Padding(padding: EdgeInsets.only(right: 10)),
                      new Text('Edit Profile',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.fontColor,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
          child: Container(
            //alignment: Alignment.topLeft,
            child: new InkWell(
              onTap: () => addItem(),
              child: new Container(
                width: 150.0,
                height: 50.0,
                decoration: new BoxDecoration(
                  color: AppColor.primaryDarkColor,
                  border: new Border.all(
                      color: AppColor.primaryDarkColor, width: 2.0),
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: new Center(
                  child: Row(
                    children: [
                      new Padding(padding: EdgeInsets.only(right: 10)),
                      new IconTheme(
                        data: new IconThemeData(color: AppColor.fontColor),
                        child: new Icon(Icons.add_circle),
                      ),
                      new Padding(padding: EdgeInsets.only(right: 10)),
                      new Text('Add Item',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.fontColor,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget myRequestsLabelSection() {
    return Column(
      children: [
        Container(
          child: new Text('My Requests',
              style: TextStyle(
                  fontSize: 16,
                  color: AppColor.primaryDarkColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold)),
        ),
        new Padding(padding: EdgeInsets.only(bottom: 10.0)),
        Container(
          height: 4,
          width: 350,
          decoration: new BoxDecoration(
            color: AppColor.primaryDarkColor,
            border:
                new Border.all(color: AppColor.primaryDarkColor, width: 0.0),
            borderRadius: new BorderRadius.circular(25.0),
          ),
        )
      ],
    );
  }

  Widget myRequestsSection() {
    return Container(
        width: MediaQuery.of(context).size.width - 20,
        child: Container(
            width: 350,
            decoration: new BoxDecoration(
                color: const Color(0xFFF5FBFF),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            height: MediaQuery.of(context).size.height,
            child: widget.isNoRequest != null
                ? getNoRequestSection()
                : TabListView()));
  }

  Widget getNoRequestSection() {
    return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 50.0),
        child: Text("You haven't requested for\n any commodity yet!",
            style: TextStyle(
                letterSpacing: 1,
                fontSize: 18,
                color: AppColor.primaryDarkColor,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500)));
  }

  void addItem() {
    print("hello!");
  }

  void editProfile() {
    Navigator.pushReplacementNamed(this.context, router.PROFILE_EDIT);
  }
}
