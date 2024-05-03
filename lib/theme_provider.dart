import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  int thememode = 0;

  ThemeMode gettheme() {
    if (thememode == 1) {
      return ThemeMode.light;
    } else if (thememode == 2) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  void changetheme(int type) {
    thememode = type;
    notifyListeners();
  }

  ThemeData getlight() {
    return ThemeData(
        brightness: Brightness.light,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.greenAccent,
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.greenAccent),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.greenAccent))),
        fontFamily: "Robot");
  }

  ThemeData getdark() {
    return ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.grey,
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.grey))),
        fontFamily: "Rubik");
  }
}
