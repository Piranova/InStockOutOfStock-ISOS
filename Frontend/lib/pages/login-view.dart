import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../router.dart' as router;
import '../util/constants.dart' as Constants;
import '../custom-widgets/custom-drawer.dart';
import '../custom-widgets/custom-app-bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user-model.dart';
import '../util/globals.dart';

final textColour = Color.fromRGBO(133, 201, 255, 1);

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  //Return a padding widget with nested text inside
  Padding createText(text, topPadding) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, topPadding, 20, 0),
      child: Text(text,
          style: TextStyle(
              fontSize: 16,
              color: textColour,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400)),
    );
  }

  //Return the text input field
  Container createInputField(String name) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        validator: (text) {
          if (text == null || text.isEmpty) {
            return "Text is empty";
          }
          return null;
        },
        onSaved: (val) {
            if(name=="email") {
              email = val;
            }else{
              password = val;
            }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(35, 44, 77, 1),
        appBar: CustomAppBar(),
        endDrawer: CustomDrawer(),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 20, 0, 0),
              child: Row(
                children: <Widget>[
                  Text("Login",
                      style: TextStyle(
                          fontSize: 30,
                          color: textColour,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Montserrat'
                          )),
                ],
              ),
            ), 
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  createText("E-Mail", 45.0),
                  createInputField('email'),
                  createText("Password", 20.0),
                  createInputField('password'),
                ]
              )
            ),

            Container(
                margin: EdgeInsets.fromLTRB(120, 20, 120, 0),
                child: RaisedButton(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text('Login',
                        style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            )),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        var result = await User(context: context).userLogin(email, password);
                        if(result != null && result == "success") {
                          Navigator.pushReplacementNamed(
                              this.context, router.HOME,
                              arguments: true);
                        }
                        }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Text("Don't have an account?",
                  style: TextStyle(fontSize: 16, color: textColour, fontFamily: 'Montserrat', fontWeight: FontWeight.w400)),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Constants.REGISTRATION);
                },
                child: Text("Sign Up!",
                    style: TextStyle(
                        fontSize: 20,
                        color: textColour,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w900,
                        
                        )),
              ),
            ),
          ],
        ));
  }
}