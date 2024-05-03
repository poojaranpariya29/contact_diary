import 'package:flutter/material.dart';
import 'contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];

  void addContact(String fnamecontroller, String lnamecontroller,
      String phoneconroller, String emailcontroller,) {
    contactList.add(ContactModel(
      fname: fnamecontroller,
      lname: lnamecontroller,
      phone: phoneconroller,
      email: emailcontroller,
    ));
    notifyListeners();
  }

  void deleteContact(int index) {
    contactList.removeAt(index);
    notifyListeners();
  }

  void editContact(int index, String fnamecontroller, String lnamecontroler,
      String phonecontroller, String emailcontroller,) {
    contactList[index] = ContactModel(
        fname: fnamecontroller,
        lname: lnamecontroler,
        phone: phonecontroller,
        email: emailcontroller,
       );
    notifyListeners();
  }
}
