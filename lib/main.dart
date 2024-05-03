import 'package:contact_diary/home_page.dart';
import 'package:contact_diary/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contact_provider.dart';

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
          home: HomePage(),
        );
      },
    );
  }
}
