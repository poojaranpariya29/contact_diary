import 'dart:io';

import 'package:contact_diary/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contact_model.dart';
import 'contact_provider.dart';

class AddPage extends StatefulWidget {
  int? index;

  AddPage({super.key, this.index});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  int currentindex = 0;

  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  String? image;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.index != null) {
      var fnameVal = Provider.of<ContactProvider>(context, listen: false)
              .contactList[widget.index!]
              .fname ??
          "";
      var lnameVal = Provider.of<ContactProvider>(context, listen: false)
              .contactList[widget.index!]
              .lname ??
          "";
      var phoneVal = Provider.of<ContactProvider>(context, listen: false)
              .contactList[widget.index!]
              .phone ??
          "";
      var emailVal = Provider.of<ContactProvider>(context, listen: false)
              .contactList[widget.index!]
              .email ??
          "";
      var imagelVal = Provider.of<ContactProvider>(context, listen: false)
              .contactList[widget.index!]
              .image ??
          "";

      fnamecontroller.text = fnameVal;
      lnamecontroller.text = lnameVal;
      phonecontroller.text = phoneVal;
      emailcontroller.text = emailVal;
      image = imagelVal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.index != null ? "Edit" : "Add",
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
        centerTitle: true,
      ),
      body: Form(
        key: fKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Stepper(
                  stepIconBuilder: (stepIndex, stepState) {},
                  currentStep: currentindex,
                  onStepTapped: (index) {
                    currentindex = index;
                    setState(() {});
                  },
                  onStepContinue: () {
                    bool isValid = fKey.currentState?.validate() ?? false;
                    if (currentindex < 4) {
                      currentindex++;
                      setState(() {});
                    } else if (isValid) {
                      return null;
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
                            details.currentStep == 4 ? "Submit" : "Next",
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
                        title: Text("PROFILE:"),
                        content: InkWell(
                          onTap: () async {
                            XFile? file = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            image = file?.path ?? "";
                            setState(() {});
                          },
                          child: CircleAvatar(
                            backgroundImage: FileImage(
                              File(image ?? ""),
                            ),
                            radius: 50,
                            child: Text(
                              (image != null) ? "" : "+ADD",
                            ),
                          ),
                        ),
                        isActive: currentindex == 0,
                        state: (fnamecontroller.text.isEmpty)
                            ? StepState.error
                            : StepState.editing),
                    Step(
                        title: Text("FIRST NAME:"),
                        content: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter first name";
                            } else {
                              return null;
                            }
                          },
                          controller: fnamecontroller,
                        ),
                        isActive: currentindex == 0,
                        state: (fnamecontroller.text.isEmpty)
                            ? StepState.error
                            : StepState.editing),
                    Step(
                        title: Text("LAST NAME:"),
                        content: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter last name";
                            } else {
                              return null;
                            }
                          },
                          controller: lnamecontroller,
                        ),
                        isActive: currentindex == 1,
                        state: (lnamecontroller.text.isEmpty)
                            ? StepState.error
                            : StepState.editing),
                    Step(
                        title: Text("PHONE:"),
                        content: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter number";
                            } else if (value.length != 10) {
                              return "Invalid Phone Number";
                            } else {
                              return null;
                            }
                          },
                          controller: phonecontroller,
                        ),
                        isActive: currentindex == 2,
                        state: (phonecontroller.text.isEmpty)
                            ? StepState.error
                            : StepState.editing),
                    Step(
                        title: Text("EMAIL:"),
                        content: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter email";
                            } else {
                              return null;
                            }
                          },
                          controller: emailcontroller,
                        ),
                        isActive: currentindex == 3,
                        state: (emailcontroller.text.isEmpty)
                            ? StepState.error
                            : StepState.editing),
                  ]),
              ElevatedButton(
                  onPressed: () {
                    if (widget.index != null) {
                      Provider.of<ContactProvider>(context, listen: false)
                          .editContact(
                        widget.index!,
                        fnamecontroller.text,
                        lnamecontroller.text,
                        phonecontroller.text,
                        emailcontroller.text,
                        image!,
                      );
                    } else {
                      Provider.of<ContactProvider>(context, listen: false)
                          .addContact(
                        fnamecontroller.text,
                        lnamecontroller.text,
                        phonecontroller.text,
                        emailcontroller.text,
                        image!,
                      );
                    }

                    Navigator.pushNamed(context, "home");
                  },
                  child: Text(widget.index != null ? "Edit" : "Add"))
            ],
          ),
        ),
      ),
    );
  }
}
