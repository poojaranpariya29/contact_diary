import 'package:contact_diary/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_page.dart';
import 'contact_model.dart';
import 'contact_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "CONTACT",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
      body: Consumer<ContactProvider>(
        builder: (BuildContext context, ContactProvider value, Widget? child) {
          return ListView.builder(
            itemCount: value.contactList.length,
            itemBuilder: (context, index) {
              ContactModel contact = value.contactList[index];

              return ListTile(
                leading: InkWell(
                  onTap: () {
                    launchUrl(Uri.parse("tel:${contact.phone}"));
                  },
                  child: CircleAvatar(
                    child: Text("${contact.fname ?? ""}"[0].toUpperCase()),
                  ),
                ),
                title: Text(contact.fname ?? ""),
                subtitle: Text(contact.phone ?? ""),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PopupMenuButton(
                      child: Icon(Icons.add),
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
                            child: Text("Share"),
                            onTap: () {
                              String con =
                                  'Please Use this number ${contact.fname ?? ""},${contact.phone ?? ""} ';
                              Share.share(con);
                            },
                          ),
                          PopupMenuItem(
                            child: Text("Edit"),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return AddPage(
                                    index: index,
                                  );
                                },
                              ));
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
