import 'package:contact_diary/home_page.dart';
import 'package:contact_diary/login_page.dart';
import 'package:contact_diary/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_page.dart';
import 'contact_provider.dart';
import 'detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemeProvider>(context).getlight(),
          darkTheme: Provider.of<ThemeProvider>(context).getdark(),
          themeMode: Provider.of<ThemeProvider>(context).gettheme(),
          initialRoute: "/",
          routes: {
            "/": (context) => LoginPage(),
            "home": (context) => HomePage(),
            "add": (context) => AddPage(),
            "detail": (context) => Detail_Page(),
          },
        );
      },
    );
  }
}
