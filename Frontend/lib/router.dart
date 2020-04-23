import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsfightcovid19/home-view.dart';
import 'login-view.dart';
import 'constants.dart' as Constants;

const String HOME = Constants.INITIAL_ROUTE;
const String LOGIN = Constants.LOGIN;

Route<dynamic> generateRoute(RouteSettings routeSettings)
{
  if(routeSettings.arguments != null)
  {
 print("routesetting arguments : "+routeSettings.arguments);
  }
 
  switch (routeSettings.name) {
    case HOME:
      return MaterialPageRoute(builder: (context) => HomeView(isUserLoggedIn: routeSettings.arguments,));
      break;
      case LOGIN:
      return MaterialPageRoute(builder: (context) => LoginView());
      break;
    default:
    return MaterialPageRoute(builder: (context) => HomeView());
  }
}