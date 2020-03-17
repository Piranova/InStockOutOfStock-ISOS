import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'router.dart' as router;

void main() => runApp(LetsFightCorona());

class LetsFightCorona extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'LetsFightCovid19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: 
        Theme.of(context).textTheme.apply(fontFamily: 'Open Sans')),
        onGenerateRoute: router.generateRoute,
        initialRoute: '/',
      );
  }
}

