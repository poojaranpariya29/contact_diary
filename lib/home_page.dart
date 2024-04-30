import 'package:contact_diary/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CONTACT",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
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
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .changetheme(value ?? 0);
                  print("value $value");
                },
              );
            },
          ),
          SingleChildScrollView(
            child: Stepper(
                currentStep: currentindex,
                onStepTapped: (index) {
                  currentindex = index;
                  setState(() {});
                },
                onStepContinue: () {
                  if (currentindex < 3) {
                    currentindex++;
                    setState(() {});
                  }
                },
                onStepCancel: () {
                  if (currentindex > 0) {
                    currentindex--;
                    setState(() {});
                  }
                },
                controlsBuilder: (context, details) {
                  return Row(
                    children: [
                      ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text(
                          details.currentStep == 3 ? "Submit" : "Next",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (details.currentStep != 0)
                        ElevatedButton(
                          onPressed: details.onStepCancel,
                          child: Text(
                            "Back",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                    ],
                  );
                },
                steps: [
                  Step(
                      title: Text("FIRST NAME:"),
                      content: TextFormField(),
                      isActive: currentindex == 0),
                  Step(
                      title: Text("LAST NAME:"),
                      content: TextFormField(),
                      isActive: currentindex == 1),
                  Step(
                      title: Text("PHONE:"),
                      content: TextFormField(),
                      isActive: currentindex == 2),
                  Step(
                      title: Text("EMAIL:"),
                      content: TextFormField(),
                      isActive: currentindex == 3),
                ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
