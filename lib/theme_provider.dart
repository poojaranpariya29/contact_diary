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
    );
  }

  ThemeData getdark() {
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.blue.shade700),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
    );
  }
}
