import 'package:flutter/material.dart';
import 'package:todo_app/styles/colors.dart';
class MyThemeData{

  static ThemeData lightTheme = ThemeData(
          appBarTheme:  AppBarTheme(
            elevation: 0,
           color: secondarylight,
              iconTheme: IconThemeData(
                  color: onSecondarylight
              )
          ),
       bottomSheetTheme: const BottomSheetThemeData(
         backgroundColor: Colors.white
       ),
       scaffoldBackgroundColor: primarylight,
       bottomNavigationBarTheme: BottomNavigationBarThemeData(
         elevation: 0,
       type:BottomNavigationBarType.fixed,
       backgroundColor: Colors.white,
       selectedItemColor:primary,
       unselectedItemColor: Colors.grey,
    ),
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primarylight,
        onPrimary: Colors.blue,//
        secondary: secondarylight,
        onSecondary: onSecondarylight,
        error: Colors.red,
        onError: floatingActionButtonSidelight,
        background: Colors.blue,//
        onBackground: Colors.blue,//
        surface:Colors.white,//
        onSurface: Colors.blue//
    ),
    dialogBackgroundColor: Colors.white

    // useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(

      appBarTheme:  AppBarTheme(
          elevation: 0,
          color: secondarylight,
        iconTheme: IconThemeData(
          color: onSecondarydark
        )
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xFF141922),
      ),
    scaffoldBackgroundColor: primarydark,
    bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
      type:BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF141922),
      selectedItemColor:Color(0xFFbac5D9CEC),
      unselectedItemColor: Color(0xFFC8C9CB),
    ),
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: primarydark,
          onPrimary: Colors.white,//
          secondary: secondarydark,
          onSecondary: onSecondarydark,
          error: Colors.red,
          onError: floatingActionButtonSidedark,
          background: Colors.yellow,//
          onBackground: Colors.blue,//
          surface: Color(0xFF1E1F22),//
          onSurface: Colors.white,//
      ),
  // dialogBackgroundColor: Colors.white

    // useMaterial3: true,
  );





}