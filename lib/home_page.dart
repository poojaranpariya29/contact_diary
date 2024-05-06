import 'dart:io';

import 'package:contact_diary/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'contact_model.dart';
import 'contact_provider.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void didChangeDependencies() {
    SharedPreferences.getInstance().then((value) {
      var themeMode = value.getInt("themeMode");
      Provider.of<ThemeProvider>(context, listen: false)
          .changetheme(themeMode ?? 0);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "CONTACT",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          SingleChildScrollView(
            child: Row(
              children: [
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
                IconButton(
                  onPressed: () async {
                    var instance = await SharedPreferences.getInstance();
                    instance.setBool("isLogin", false);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ));
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (BuildContext context, ContactProvider value, Widget? child) {
          return ListView.builder(
            itemCount: value.contactList.length,
            itemBuilder: (context, index) {
              ContactModal contact = value.contactList[index];

              return ListTile(
                leading: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "detail",
                        arguments: value.contactList[index]);
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: FileImage(
                      File(contact.image ?? ""),
                    ),
                  ),
                ),
                title: Text(contact.fname ?? ""),
                subtitle: Text(contact.phone ?? ""),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        launchUrl(Uri.parse("tel:${contact.phone}"));
                      },
                      child: Icon(
                        Icons.call,
                        color: Colors.green,
                      ),
                    ),
                    PopupMenuButton(
                      tooltip: "",
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text("Delete"),
                            onTap: () {
                              Provider.of<ContactProvider>(context,
                                      listen: false)
                                  .deleteContact(index);
                            },
                          ),
                          PopupMenuItem(
                            child: Text("Edit"),
                            onTap: () {
                              Navigator.pushNamed(context, "add",
                                  arguments: contact);
                            },
                          ),
                        ];
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            "add",
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
