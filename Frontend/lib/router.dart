import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:InStockOrOutOfStock/pages/home-view.dart';
import 'login-view.dart';
import 'registration.dart';
import './util/constants.dart' as Constants;
import 'thank-you-view.dart';
import 'email-confirmation-view.dart';

const String HOME = Constants.INITIAL_ROUTE;
const String LOGIN = Constants.LOGIN;
const String REGISTRATION = Constants.REGISTRATION;
const String THANKYOU = Constants.THANKYOU;
const String EMAIL_CONFIRMATION = Constants.EMAIL_CONFIRMATION;

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
    case REGISTRATION:
      return MaterialPageRoute(builder: (context) => RegistrationView());
      break;
    case THANKYOU:
      return MaterialPageRoute(builder: (context) => ThankYouView());
      break;
    case EMAIL_CONFIRMATION:
      return MaterialPageRoute(builder: (context) => EmailConfirmationView());
      break;
    default:
      return MaterialPageRoute(builder: (context) => HomeView());
      //HomeView as default
  }
}