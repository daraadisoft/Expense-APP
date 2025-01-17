import 'package:flutter/material.dart';

class AppColor {
  static const Color primaryColor = Color.fromRGBO(255, 217, 73, 1);

  static const Color grey = Color.fromRGBO(187, 184, 185, 1.0);

  static const Color errorColor = Color.fromRGBO(215, 19, 19, 1);

  static const Color white = Colors.white;

  static const Color black = Colors.black;

  static const Color grey200 = Colors.grey;

  static Color decodeColor({required String hex}){
    try{
      return Color(int.parse('FF$hex', radix: 16));
    }catch(e){
      return primaryColor;
    }
  }
}
