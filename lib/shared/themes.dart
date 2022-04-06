import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme:const IconThemeData(
        color: Colors.white
    ),
    backgroundColor:HexColor('153950') ,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('153950'),
        statusBarIconBrightness: Brightness.light
    ),
    titleTextStyle:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
  ),
  scaffoldBackgroundColor: HexColor('153950'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor:Colors.white,
      unselectedItemColor: Colors.grey,
      backgroundColor:  HexColor('162d3b')
  ),

);



ThemeData lightTheme = ThemeData(
  //fontFamily: 'DanielDavis',
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:const AppBarTheme(
    iconTheme: IconThemeData(
        color: Colors.blue
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarIconBrightness: Brightness.light
    ),
    titleTextStyle: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),
  ),

);



