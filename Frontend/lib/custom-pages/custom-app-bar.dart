import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final chosenBackGroundColor = Color.fromRGBO(35, 44, 77, 1);
  final chosenTextColour = Color.fromRGBO(133, 201, 255, 1);

  @override
  Widget build(BuildContext context) {
    
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: chosenBackGroundColor,
        iconTheme: new IconThemeData(color: chosenTextColour),

        title: Container(
          width: 300,
          height: 25,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
          ),
        ),
        elevation: 0,
      );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);

}