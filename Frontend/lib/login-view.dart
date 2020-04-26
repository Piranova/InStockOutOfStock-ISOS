import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'router.dart' as router;
import 'package:letsfightcovid19/util/constants.dart' as Constants;

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: Center(
            child: (Column(
      children: <Widget>[
        Text('Login Page will be displayed here'),
        FlatButton(
          child: Text('Submit Login'),
          onPressed: () {
                        Navigator.pushReplacementNamed(this.context, router.HOME, arguments: Constants.LOGOUT);
          },
        )
      ],
    ))));
  }
}
