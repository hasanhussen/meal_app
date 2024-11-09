import 'package:flutter/material.dart';

class OnBoardingProvider with ChangeNotifier {
  int currentIndex = 0;

  void onPageChanged(int val) {
    currentIndex = val;
    notifyListeners();
  }
}
