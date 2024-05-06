import 'dart:io';

import 'package:contact_diary/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import 'contact_model.dart';
import 'contact_provider.dart';

class Detail_Page extends StatefulWidget {
  const Detail_Page({Key? key}) : super(key: key);

  @override
  State<Detail_Page> createState() => _Detail_PageState();
}

class _Detail_PageState extends State<Detail_Page> {
  void didChangeDependencies() {
    SharedPreferences.getInstance().then((value) {
      var themeMode = value.getInt("themeMode");
      print("My Save Val $themeMode");
      Provider.of<ThemeProvider>(context, listen: false)
          .changetheme(themeMode ?? 0);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ContactModal value =
        ModalRoute.of(context)?.settings.arguments as ContactModal;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${value.fname}",
        ),
        actions: [
          Consumer<ThemeProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return DropdownButton(
                value: value.thememode,
                items: [
                  DropdownMenuItem(child: Text("System"), value: 0),
                  DropdownMenuItem(child: Text("Light"), value: 1),
                  DropdownMenuItem(child: Text("Dark"), value: 2),
                ],
                onChanged: (value) async {
                  var instance = await SharedPreferences.getInstance();
                  instance.setInt("themeMode", value ?? 0);

                  Provider.of<ThemeProvider>(context, listen: false)
                      .changetheme(value ?? 0);
                  print("value $value");
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Spacer(
                flex: 8,
              ),
              CircleAvatar(
                backgroundImage: FileImage(
                  File(value.image ?? ""),
                ),
                backgroundColor: Colors.grey,
                radius: 55,
                child: Text(
                  (value.image != null) ? "" : "ADD",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              IconButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: const Text('Are You Sure...'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(dialogContext)
                                    .pop(); // Dismiss alert dialog
                              },
                            ),
                            TextButton(
                              child: const Text('yes'),
                              onPressed: () {
                                Provider.of<ContactProvider>(context,
                                        listen: false)
                                    .deleteContact(value as int);

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/', (route) => false);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete)),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "add",
                        arguments: (index: value));
                  },
                  icon: const Icon(Icons.edit)),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "${value.fname} ${value.lname}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "+91 ${value.phone} ",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  Uri url = Uri.parse("tel:+91${value.phone}");

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Can't be launched..."),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                heroTag: null,
                mini: true,
                backgroundColor: Colors.green,
                child: const Icon(Icons.call),
              ),
              FloatingActionButton(
                onPressed: () async {
                  Uri url = Uri.parse("sms:+91${value.phone}");

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Can't be launched..."),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                heroTag: null,
                mini: true,
                backgroundColor: Colors.amber,
                child: const Icon(Icons.message),
              ),
              FloatingActionButton(
                onPressed: () async {
                  Uri url = Uri.parse(
                      "mailto:${value.email}?subject=Demo&body=Hello");

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Can't be launched..."),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                heroTag: null,
                mini: true,
                backgroundColor: Colors.lightBlueAccent,
                child: const Icon(Icons.email_outlined),
              ),
              FloatingActionButton(
                onPressed: () async {
                  await Share.share(
                      "Name: ${value.fname} ${value.lname}\n+91 ${value.phone}");
                },
                heroTag: null,
                mini: true,
                backgroundColor: Colors.deepOrangeAccent,
                child: const Icon(Icons.share),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
            indent: 20,
            endIndent: 20,
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
