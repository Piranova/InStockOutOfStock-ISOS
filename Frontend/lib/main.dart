import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'router.dart' as router;

void main() => runApp(LetsFightCorona());

class LetsFightCorona extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'In Stock Or Out Of Stock',
      theme: ThemeData(
        textTheme:
        Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
//        primaryColor: const Color(0xFF232C4D),
        scaffoldBackgroundColor: const Color(0xFF85C9FF),
        fontFamily: 'Montserrat',
        tabBarTheme: TabBarTheme(
          labelColor: const Color(0xFF232C4D),
          unselectedLabelColor: const Color(0xFF232C4D),
          labelStyle: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontFamilyFallback: ['Georgia']),
          unselectedLabelStyle: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontFamilyFallback: ['Georgia'])
        ),
      ),
      onGenerateRoute: router.generateRoute,
        initialRoute: '/',
    );
  }
}

