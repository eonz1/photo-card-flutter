import 'package:flutter/material.dart';

class ProfileNotifier with ChangeNotifier {
  String _nickname = "";
  String _email = "";

  String get nickname => _nickname;

  String get email => _email;

  void changeNickname(String value) {
    _nickname = value;
    notifyListeners();
  }

  void changeEmail(String value) {
    _email = value;
    notifyListeners();
  }
}
