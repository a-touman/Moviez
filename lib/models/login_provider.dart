import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String lName;
  String lSeed;

  LoginProvider({this.lName = "", this.lSeed = "x_x"});

  void changeNamePfp(String value) {
    lName = value;
    lSeed = value;
    notifyListeners();
  }
}
