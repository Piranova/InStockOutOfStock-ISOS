import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/globals.dart';
import '../util/constants.dart' as Constants;


class User{
  String email;
  String name;
  String address;
  BuildContext context;

  User({Key key, this.context, this.email, this.name, this.address});

  Future<String> register(String name, String email, String password, String confirm_password) async {
    final response = await http.post(App.url + 'register',
                                body: {
                                  'name': name,
                                  'email': email,
                                  'password': password,
                                  'confirm_password': confirm_password
                                });
    print("response is: " + response.statusCode.toString() + " " + response.body.toString());
    var jsonResponse = json.decode(response.body);
    if(response.statusCode == 200){
      var status = jsonResponse['result'];
      if(status == 'failure'){
        showAlertDialog(jsonResponse);
      }else{
        //User.fromJson(jsonResponse);
        this.name = name;
        this.email = email;
        onSuccess();
        return 'success';
      }
    }else{
      showAlertDialog(jsonResponse);
    }

  }

  Future<String> userLogin(String email, String password) async {
    final response = await http.post(App.url + 'login',
                        body: {
                          'email': email,
                          'password': password
                        });
      print("response is : " + response.statusCode.toString() + " " + response.body.toString());
      var jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
      var status = jsonResponse['result'];
      if (status == 'failure') {
        showAlertDialog(jsonResponse);
      }else{
        this.email = email;
        onSuccess();
        return 'success';
      }
    } else {
      showAlertDialog(jsonResponse);
    }
  }



  void onSuccess() async{
    App.localStorage.setBool(Constants.ISLOGGED, true);

//    if(!App.localStorage.containsKey('email'))
      App.localStorage.setString('email', email);
      App.localStorage.setString('name', name);
      App.localStorage.setString('address', address);
  }

  void showAlertDialog(var jsonResponse) {
    showDialog(
      context: context,
      builder: (BuildContext context)
    {
      return AlertDialog(
        title: Text(jsonResponse['message']),
        content: Text(jsonResponse['result']),
        actions: [
          new FlatButton(
              child: const Text("Ok"),
            onPressed: (){
                Navigator.of(context).pop();
            },
          ),
        ],
      );
      },
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      name: json['name'],
      address: json['address'],
    );
  }


}

