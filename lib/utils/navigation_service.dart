// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Navigation service help manage navigating from route to route
class NavigationService {
  static final NavigationService instance = NavigationService._();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigationService._();

  factory NavigationService() {
    return instance;
  }


  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;


  BuildContext get context => _navigatorKey.currentContext!;

  Future<dynamic> push(Widget widget) async {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ));
  }

  Future<dynamic> pushAndRemoveUntil(Widget widget) async {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => widget),
          (route) => false,
    );
  }


  Future<dynamic> replace(Widget widget) async {
    return Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ));
  }


  pop({Object? result}) async {
    Navigator.of(context).pop(result);
  }


  popToTop() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<dynamic> pushNamed(
      String routeName, {
        Object? arguments,
      }) {
    return Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replaceNamed(
      String routeName, {
        dynamic result,
        Object? arguments,
      }) {
    return Navigator.of(context)
        .pushReplacementNamed(routeName, arguments: arguments);
  }
}
