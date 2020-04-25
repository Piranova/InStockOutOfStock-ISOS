import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'router.dart' as router;
import 'constants.dart' as Constants;
import './custom-pages/custom-drawer.dart';
import './custom-pages/custom-app-bar.dart';


class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final textColour = Color.fromRGBO(133, 201, 255, 1);

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
            Padding(
              padding: EdgeInsets.fromLTRB(30, 40, 20, 0),
              child: Text("E-Mail",
                  style: TextStyle(fontSize: 16, color: textColour, fontFamily: 'Montserrat', fontWeight: FontWeight.w400)),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 20, 0),
              child: Text("Password",
                  style: TextStyle(fontSize: 16, color: textColour, fontWeight: FontWeight.w400, fontFamily: 'Montserrat')),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
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
                  onPressed: () {
                    Navigator.pushReplacementNamed(this.context, router.HOME,
                        arguments: Constants.LOGOUT);
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
                  Navigator.pushNamed(context, "REGISTRATION");
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

