import 'package:flutter/material.dart';
import '../custom-widgets/custom-app-bar.dart';
import '../custom-widgets/custom-drawer.dart';

class ThankYouView extends StatelessWidget {
  final textColour = Color.fromRGBO(133, 201, 255, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 44, 77, 1),
      appBar: CustomAppBar(),
      endDrawer: CustomDrawer(),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text(
              "Thanks for signing up!", 
              style: TextStyle(
                fontFamily: 'MontSerrat',
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: textColour
              )
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 30, 0),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              "Please check your E-Mail Inbox and confirm your sign up with us.", 
              style: TextStyle(
                fontFamily: 'MontSerrat',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: textColour
              )
            ),
          )
        ],
      )
    );
  }
}