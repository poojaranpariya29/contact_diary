import 'package:contact_diary/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void didChangeDependencies() {
    {
      SharedPreferences.getInstance().then((value) {
        var themeMode = value.getInt("themeMode");
        Provider.of<ThemeProvider>(context, listen: false)
            .changetheme(themeMode ?? 0);
      });
      super.didChangeDependencies();
    }

    SharedPreferences.getInstance().then((pref) {
      var isLogin = pref.getBool("isLogin");
      if (isLogin ?? false) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: fKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.30,
                  width: MediaQuery.sizeOf(context).width * 0.30,
                  child: const Image(
                    image: AssetImage("assets/images/login.png"),
                  ),
                ),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "Email:", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Email Address:";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: pass,
                  decoration: InputDecoration(
                      hintText: "Password", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter password";
                    }
                  },
                ),
                SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                    onPressed: () async {
                      var isVAl = fKey.currentState?.validate() ?? false;
                      if (isVAl) {
                        if (email.text == "pooja@gmail.com" &&
                            pass.text == "123456") {
                          var sp = await SharedPreferences.getInstance();
                          await sp.setBool("isLogin", true);

                          Navigator.pushNamed(
                            context,
                            "home",
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Invalid"),
                            ),
                          );
                        }
                      } else {}
                    },
                    child: Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
