import 'package:flutter/material.dart';
import '../utils/my_colors.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    //primarySwatch: Colors.blue,
    // brightness: Brightness.light,
    useMaterial3: true,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primaryTextTheme: TextTheme(titleLarge: TextStyle(color: Colors.black)),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
      ),
      headlineMedium: TextStyle(
        color: Colors.black54,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
      displaySmall: TextStyle(
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        color: Colors.black,
      ),
      displayLarge: TextStyle(
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
      ),
      labelSmall: TextStyle(
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: MyColors.primary,
    brightness: Brightness.dark,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: MyColors.primary,
    ),
    canvasColor: MyColors.primary,
    appBarTheme: AppBarTheme(
      color: MyColors.primary,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    dividerColor: Colors.grey.shade800,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),
    cardTheme: CardTheme(
      color: MyColors.primary,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
      ),
      displayLarge: TextStyle(
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
