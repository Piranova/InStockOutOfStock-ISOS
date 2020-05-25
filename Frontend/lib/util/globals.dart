
import 'package:shared_preferences/shared_preferences.dart';

class App {
  static String mode = "development";
  static String url = mode =="development" ? 'http://192.168.99.100:5000/isos/' : 'http://ec2-3-134-253-154.us-east-2.compute.amazonaws.com:5000/isos/';
  static SharedPreferences localStorage;
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }
}