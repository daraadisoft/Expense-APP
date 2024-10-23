import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetHelper{
  static Future<bool> isHasInternetConnection() async {
    return await InternetConnection().hasInternetAccess;
  }
}