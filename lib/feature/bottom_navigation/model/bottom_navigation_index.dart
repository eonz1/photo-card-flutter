import 'package:flutter/cupertino.dart';

class BottomNavigationIndex with ChangeNotifier {
  int _state = 0;
  int get state => _state;

  void set(int index) {
    _state = index;
    notifyListeners();
  }
}