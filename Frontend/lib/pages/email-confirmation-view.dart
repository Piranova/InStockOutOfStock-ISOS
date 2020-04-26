import 'package:flutter/material.dart';
import '../custom-pages/custom-app-bar.dart';
import '../custom-pages/custom-drawer.dart';

class EmailConfirmationView extends StatelessWidget {
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
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Text(
              "E-Mail address has been confirmed! ", 
              style: TextStyle(
                fontFamily: 'MontSerrat',
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: textColour,
                height: 1.8,
              )
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 30, 0),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              "You can now edit your profile and add new comments.", 
              style: TextStyle(
                fontFamily: 'MontSerrat',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.8,
                color: textColour
              )
            ),
          )
        ],
      )
    );
  }
}