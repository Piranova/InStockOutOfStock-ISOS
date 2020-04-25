import 'package:flutter/material.dart';
import './custom-pages/custom-drawer.dart';
import './custom-pages/custom-app-bar.dart';

class RegistrationView extends StatefulWidget {
  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 44, 77, 1),
      appBar: CustomAppBar(),
      endDrawer: CustomDrawer(),
      // BEFORE MOVE ON, LETS SEE HOW TO POSITION THE DRAWSER MUSHROm
      
    );
  }
}
