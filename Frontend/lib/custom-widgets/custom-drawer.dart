import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final chosenBackGroundColor = Color.fromRGBO(35, 44, 77, 1);
  final chosenTextColour = Color.fromRGBO(133, 201, 255, 1);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              chosenBackGroundColor, //This will change the drawer background to blue.
          //other styles
        ),
        child: Drawer(
            child: ListView(
          children: <Widget>[
            SizedBox(height: 230),
            ListTile(
                title: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "HOME");
                    },
                    child: Text("Home", textAlign: TextAlign.right, style: TextStyle(fontSize: 20, color: chosenTextColour, fontFamily: 'MontSerrat', fontWeight: FontWeight.w900)))),
            ListTile(
                title: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "LOGIN");
                    },
                    child:
                        Container(child: Text("Log In", textAlign: TextAlign.right, style: TextStyle(fontSize: 20, color: chosenTextColour,fontFamily: 'MontSerrat', fontWeight: FontWeight.w900))))),
            ListTile(
                title: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "HOME"); // TO BE CHANGED TO About US
                    },
                    child:
                        Text("About Us", textAlign: TextAlign.right, style: TextStyle(fontSize: 20,color: chosenTextColour,fontFamily: 'MontSerrat', fontWeight: FontWeight.w900)))),
          ],
        )),
      ),
    );
  }
}
