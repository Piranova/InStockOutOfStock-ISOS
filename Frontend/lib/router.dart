import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:InStockOrOutOfStock/pages/home-view.dart';
import 'package:InStockOrOutOfStock/util/constants.dart' as Constants;

const String HOME = Constants.INITIAL_ROUTE;
const String LOGIN = Constants.LOGIN;

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  if (routeSettings.arguments != null) {
  }

  switch (routeSettings.name) {
    case HOME:
      return MaterialPageRoute(
          builder: (context) => HomeView(
                isUserLoggedIn: routeSettings.arguments,
              ));
      break;
    default:
      return MaterialPageRoute(builder: (context) => HomeView());
  }
}
