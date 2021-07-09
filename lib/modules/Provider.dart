import 'package:flutter/material.dart';

import '../User.dart';

class Providerr with ChangeNotifier {
  bool darkOn = false;
  UserData currentUser;
  bool favorite = false;

  void fav() {
    favorite = !favorite;
    notifyListeners();
  }

  void darkModeActivation(bool mode) {
    darkOn = mode;
    notifyListeners();
  }

  void assignTheUser(UserData user) {
    currentUser = user;
    notifyListeners();
  }

  void changeUserInfomation(
      String name, String phone, String pass, String imageUrl) {
    currentUser.name = name;
    currentUser.phone = phone;
    currentUser.pass = pass;
    if (currentUser.imageUrl != imageUrl) currentUser.imageUrl = imageUrl;
    notifyListeners();
  }
}
