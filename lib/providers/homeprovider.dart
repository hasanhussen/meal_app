import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int selectPage = 0;

  void changpage(int index) {
    selectPage = index;
    notifyListeners();
  }
}
