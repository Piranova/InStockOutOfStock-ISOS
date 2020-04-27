import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../router.dart' as router;
import '../util/constants.dart' as Constants;
import 'package:sprintf/sprintf.dart';
import '../custom-widgets/custom-drawer.dart';
import '../custom-widgets/custom-app-bar.dart';
import '../util/appcolor.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key key}) : super(key: key);

  _ProfileViewState createState() => new _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  void navDrawBar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        endDrawer: CustomDrawer(),
        backgroundColor: AppColor.primaryColor,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Stack(children: <Widget>[profileScreen()]),
            )
          ],
        ));
  }

  Padding createText(text, topPadding) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, topPadding, 20, 5),
      child: Container(
        alignment: Alignment.topLeft,
        //padding: EdgeInsets.only(rig:5),
        child: Text(text,
            style: TextStyle(
                fontSize: 16,
                color: AppColor.primaryDarkColor,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400)),
      ),
    );
  }

  Widget createInputField(obscureText, keyboardType) {
    return Container(
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
      ),
    );
  }

  Widget profileScreen() {
    return Center(
        child: new Container(
            padding: const EdgeInsets.only(right: 30.0, left: 30.0),
            child: new Container(
              child:
                  new Center(child: new Column(children: getProfileSection())),
            )));
  }

  List<Widget> getProfileSection() {
    List<Widget> profileSectionList = List<Widget>();
    profileSectionList.add(new Padding(padding: EdgeInsets.only(top: 0.0)));
    //profileSectionList.addAll(profilePicSection());
    profileSectionList.addAll(personalInfoSection());
    profileSectionList.addAll(changePasswordSection());
    profileSectionList.add(savePasswordBtn());
    profileSectionList.add(new Padding(padding: EdgeInsets.only(bottom: 10.0)));
    return profileSectionList;
  }

  /*List<Widget> profilePicSection() {
    List<Widget> profilePicList = List<Widget>();
    profilePicList.add(new Row(
      children: <Widget>[
        new Padding(padding: EdgeInsets.only(left: 10.0)),
        Container(
          child: Image.asset("assets/dpp.jpg"),
          height: 160,
          width: 120,
        ),
        new Padding(padding: EdgeInsets.only(right: 50.0)),
        new InkWell(
          onTap: () => print('edit avtar'),
          child: new Container(
            width: 150.0,
            height: 60.0,
            decoration: new BoxDecoration(
              color: Color(0xFF232C4D),
              border: new Border.all(color: Color(0xFF232C4D), width: 2.0),
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: Row(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[
                new Padding(padding: EdgeInsets.only(left:20, )),
                Icon(IconData(58313, fontFamily: 'MaterialIcons'),color: Color(0xFFF5FBFF),),
                new Padding(padding: EdgeInsets.only(left:10)),
                new Center(
                  child: new Text('Edit Avatar',
                      style: new TextStyle(
                          fontSize: 18.0, color: Color(0xFFF5FBFF))),
                )
              ],
            ),
          ),
        )
      ],
    ));
    return profilePicList;
  }*/

  List<Widget> personalInfoSection() {
    List<Widget> personalInfoSectionList = List<Widget>();
    /*personalInfoSectionList
        .add(new Padding(padding: EdgeInsets.only(top: 30.0)));
    personalInfoSectionList.add(getField("Name"));
    personalInfoSectionList
        .add(new Padding(padding: EdgeInsets.only(top: 30.0)));
    personalInfoSectionList.add(getField("Email"));
    personalInfoSectionList
        .add(new Padding(padding: EdgeInsets.only(top: 30.0)));
    personalInfoSectionList.add(getField("Address"));
    personalInfoSectionList
        .add(new Padding(padding: EdgeInsets.only(bottom: 40.0)));*/
    personalInfoSectionList.add(createText("Name", 30.0));
    personalInfoSectionList.add(createInputField(false, TextInputType.text));
    personalInfoSectionList.add(createText("Email", 30.0));
    personalInfoSectionList.add(createInputField(false, TextInputType.emailAddress));
    personalInfoSectionList.add(createText("Address", 30.0));
    personalInfoSectionList.add(createInputField(false, TextInputType.multiline));
    personalInfoSectionList
        .add(new Padding(padding: EdgeInsets.only(bottom: 40.0)));
    return personalInfoSectionList;
  }

  List<Widget> changePasswordSection() {
    List<Widget> changePasswordSectionList = List<Widget>();
    changePasswordSectionList.add(changePasswordLabel());
    changePasswordSectionList
        .add(new Padding(padding: EdgeInsets.only(bottom: 5.0)));
    changePasswordSectionList.add(Container(
        height: 5,
        decoration: new BoxDecoration(
          color: AppColor.primaryDarkColor,
          border: new Border.all(color: AppColor.primaryDarkColor, width: 0.0),
          borderRadius: new BorderRadius.circular(25.0),
        ),
        child: Divider(thickness: 1, color: AppColor.primaryDarkColor)));
    /*changePasswordSectionList
        .add(new Padding(padding: EdgeInsets.only(bottom: 50.0)));
    changePasswordSectionList.add(getField("Current Password"));
    changePasswordSectionList
        .add(new Padding(padding: EdgeInsets.only(top: 30.0)));
    changePasswordSectionList.add(getField("New Password"));
    changePasswordSectionList
        .add(new Padding(padding: EdgeInsets.only(top: 30.0)));
    changePasswordSectionList.add(getField("Confirm New Password"));*/
    changePasswordSectionList.add(createText("Current Password", 30.0));
    changePasswordSectionList.add(createInputField(true, null));
    changePasswordSectionList.add(createText("New Password", 30.0));
    changePasswordSectionList.add(createInputField(true, null));
    changePasswordSectionList.add(createText("Confirm New Password", 30.0));
    changePasswordSectionList.add(createInputField(true, null));
    changePasswordSectionList
        .add(new Padding(padding: EdgeInsets.only(bottom: 40.0)));
    return changePasswordSectionList;
  }

  Widget changePasswordLabel() {
    return new Container(
        child: new Text(
      'Change Password',
      style: new TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 22.0,
          color: AppColor.primaryDarkColor),
    ));
  }

  Widget savePasswordBtn() {
    return new InkWell(
      onTap: () => processProfileForm(),
      child: new Container(
        width: 250.0,
        height: 70.0,
        decoration: new BoxDecoration(
          color: AppColor.primaryDarkColor,
          border: new Border.all(color: AppColor.primaryDarkColor, width: 2.0),
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child: new Center(
          child: new Text('Save Changes',
              style: new TextStyle(fontSize: 18.0, color: AppColor.fontColor)),
        ),
      ),
    );
  }

  Widget getField(fieldName) {
    TextInputType fieldTextInputType = null;
    bool obscureText = false;
    switch (fieldName) {
      case "Email":
        fieldTextInputType = TextInputType.emailAddress;
        break;
      case "Address":
        fieldTextInputType = TextInputType.multiline;
        break;
      case "Current Password":
        fieldTextInputType = TextInputType.visiblePassword;
        obscureText = true;
        break;
      case "Confirm New Password":
        fieldTextInputType = TextInputType.visiblePassword;
        obscureText = true;
        break;
      case "New Password":
        fieldTextInputType = TextInputType.visiblePassword;
        obscureText = true;
        break;
      default:
        fieldTextInputType = TextInputType.text;
        break;
    }

    Widget textField = TextFormField(
      obscureText: obscureText,
      decoration: new InputDecoration(
        focusColor: AppColor.fontColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryDarkColor, width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryDarkColor, width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        labelStyle:
            new TextStyle(color: AppColor.primaryDarkColor, fontSize: 16.0),
        labelText: sprintf("%s", [fieldName]),
        fillColor: AppColor.fontColor,
        filled: true,
        border: new OutlineInputBorder(
          borderSide: const BorderSide(
              color: Colors.white, width: 2.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(25.0),
        ),
        //fillColor: Colors.green
      ),
      validator: (val) {
        if (val.length == 0) {
          return sprintf("%s cannot be empty", [fieldName]);
        } else {
          return null;
        }
      },
      keyboardType: fieldTextInputType,
      style: new TextStyle(
        fontFamily: "Poppins",
      ),
    );
    return textField;
  }

  void processProfileForm() {
    print("hello!");
  }
}
