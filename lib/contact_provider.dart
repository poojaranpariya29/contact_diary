import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModal> contactList = [];
  Uint8List? savedImg;

  final key = GlobalKey<FormState>();

  void addContact(
    String fnamecontroller,
    String lnamecontroller,
    String phoneconroller,
    String emailcontroller,
    String image,
  ) {
    contactList.add(ContactModal(
      fname: fnamecontroller,
      lname: lnamecontroller,
      phone: phoneconroller,
      email: emailcontroller,
      image: image,
    ));
    notifyListeners();
  }

  void deleteContact(int index) {
    contactList.removeAt(index);
    notifyListeners();
  }

  void editContact(
    int index,
    String fnamecontroller,
    String lnamecontroler,
    String phonecontroller,
    String emailcontroller,
    String image,
  ) {
    contactList[index] = ContactModal(
        fname: fnamecontroller,
        lname: lnamecontroler,
        phone: phonecontroller,
        email: emailcontroller,
        image: image);
    notifyListeners();
  }
}
