import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int themeMode = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getlight(),
      darkTheme: getdark(),
      themeMode: getthememode(themeMode),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text(
            "Diary",
            style: TextStyle(color: Colors.green),
          ),
          centerTitle: true,
          actions: [
            InkWell(
                onTap: () {
                  if (themeMode == 0) {
                    themeMode = 1;
                  } else if (themeMode == 1) {
                    themeMode = 2;
                  } else {
                    themeMode = 0;
                  }
                  setState(() {});
                },
                child: Icon(Icons.settings))
          ],
        ),
        body: Column(
          children: [
            Text("TITLE:", style: Theme.of(context).textTheme.titleLarge),
            Text(
              "POOJA PATEL",
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
      ),
    );
  }

  ThemeMode getthememode(int type) {
    if (type == 0) {
      return ThemeMode.system;
    } else if (type == 1) {
      return ThemeMode.light;
    } else if (type == 2) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
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
