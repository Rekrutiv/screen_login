import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Palette {
 static const Color iconColor = Color(0xFFB6C7D1);
 static const Color activeColor = Color(0xFF09126C);
 static const Color textColor1 = Color(0XFFA7BCC7);
 static const Color textColor2 = Color(0XFF9BB3C0);
 static const Color facebookColor = Color(0xFF3B5999);
 static const Color googleColor = Color(0xFFDE4B39);
 static const Color backgroundColor = Color(0xFFECF3F9);
 static const COLOR_WHITE = Colors.white;

 static const TextTheme TEXT_THEME_SMALL = TextTheme(
     headline1: TextStyle(
         color: activeColor, fontWeight: FontWeight.w700, fontSize: 22),
     headline2: TextStyle(
         color:googleColor,  fontSize: 8),
     bodyText1: TextStyle(
         color:textColor1, fontSize: 10, fontWeight: FontWeight.w300,height: 1),
     bodyText2: TextStyle(
         color:  COLOR_WHITE, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
     subtitle1:
     TextStyle(color: textColor1, fontSize: 14, fontWeight: FontWeight.w400),
     subtitle2: TextStyle(
         color: googleColor, fontSize: 10, fontWeight: FontWeight.w400));
}