import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';
import 'util/globals.dart';
import 'util/constants.dart' as Constants;

void main() async {
  await App.init();
  bool isLogged = (App.localStorage.getBool(Constants.ISLOGGED) ?? false) ;
  App.localStorage.setBool(Constants.ISLOGGED, isLogged);
print("isLogged is " + isLogged.toString());
  runApp(LetsFightCorona(isUserLoggedIn: isLogged));
}

class LetsFightCorona extends StatelessWidget {
  final bool isUserLoggedIn;
  LetsFightCorona({Key key, this.isUserLoggedIn}) : super(key: key);

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
        cardColor: Color(0xFFF5FBFF),
        tabBarTheme: TabBarTheme(
          labelColor: const Color(0xFF232C4D),
          unselectedLabelColor: const Color(0xFF232C4D),
          labelStyle: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontFamilyFallback: ['Georgia']),
          unselectedLabelStyle: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontFamilyFallback: ['Georgia'])
        ),
      ),
      onGenerateRoute: router.generateRoute,
//      (RouteSettings settings) {
//        print("comng in generateroute");
//        router.generateRoute(settings);
////        if(settings.name == Constants.INITIAL_ROUTE) {
////          router.generateRoute(
////              RouteSettings(name: '/', arguments: isUserLoggedIn));
////        }else{
////          router.generateRoute(settings);
////        }
//        },
    onGenerateInitialRoutes: (String name){
        return [
              router.generateRoute(RouteSettings(name: '/', arguments: isUserLoggedIn))
        ];
    },
        initialRoute: '/',
    );
  }
}

