import 'package:flutter/material.dart';
import '../custom-widgets/custom-drawer.dart';
import '../custom-widgets/custom-app-bar.dart';
import '../util/constants.dart' as Constants;
import '../router.dart' as router;
import '../models/user-model.dart';

class RegistrationView extends StatefulWidget {
  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final textColour = Color.fromRGBO(133, 201, 255, 1);
  String name;
  String email;
  String password;
  String confirm_password;

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
  Container createInputField(String field) {
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
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Field is empty";
          }
        },
          onSaved: (val) {
            if(field == "name"){
              name = val;
            }else if(field == "email"){
              email = val;
            }else if(field == "password"){
              password = val;
            }else if(field == "conpswd"){
              confirm_password = val;
            }
        },
      ),
    );
  }

  // Each InputField needs to have a Padding Widget On Top
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: Color.fromRGBO(35, 44, 77, 1),
        appBar: CustomAppBar(),
        endDrawer: CustomDrawer(),
        // BEFORE MOVE ON, LETS SEE HOW TO POSITION THE DRAWSER MUSHROm
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 20, 0, 0),
            child: Row(
              children: <Widget>[
                Text("Sign Up",
                    style: TextStyle(
                        fontSize: 30,
                        color: textColour,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Montserrat')),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                createText("Name", 40.0),
                createInputField("name"),
                createText("E-Mail", 15.0),
                createInputField("email"),
                createText("Password", 15.0),
                createInputField("password"),
                createText("Confirm Password", 15.0),
                createInputField("conpswd"),
                Container(
                    margin: EdgeInsets.fromLTRB(80, 25, 80, 0),
                    // width: 200,
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      color: Colors.white,
                      child: Text('Create Account',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          )),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          _formKey.currentState.save();

                          var result = await User(context: context).register(this.name, this.email, this.password, this.confirm_password);
                          if(result != null && result == 'success') {
                            Navigator.pushReplacementNamed(
                                this.context, router.THANKYOU);
                          }
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    )),
              ],
            )
          ),


          Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Text("Already have an account?",
                style: TextStyle(
                    fontSize: 16,
                    color: textColour,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "LOGIN");
              },
              child: Text("Login!",
                  style: TextStyle(
                    fontSize: 20,
                    color: textColour,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                  )),
            ),
          ),
        ]));
  }
}
