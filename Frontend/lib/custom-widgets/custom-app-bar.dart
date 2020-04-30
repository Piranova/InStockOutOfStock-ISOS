import 'package:flutter/material.dart';
import '../util/appcolor.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 15, 0),
      child: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text("Welcome, \n What are you looking for?", style: TextStyle(color: AppColor.primaryDarkColor),),
          // padding: EdgeInsets.all(16.0),
          // width: 400,
          // height: 50,
          // decoration: new BoxDecoration(
          //   color: AppColor.primaryDarkColor,
          //   border: new Border.all(color: AppColor.primaryDarkColor, width: 2.0),
          //   borderRadius: new BorderRadius.circular(25.0),
          // ),
          // child: Divider(thickness: 10, color: AppColor.primaryDarkColor),
        ),
        backgroundColor: AppColor.primaryColor,
        iconTheme: IconThemeData(
            opacity: 20,
            color: AppColor.primaryDarkColor,
            size: IconTheme.of(context).size),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);

}