// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = const Color(0xFF673AB7);
  var accentColor = const Color(0xFF9E9E9E);
  ThemeMode tm = ThemeMode.system;
  String themeText = "s";

  onChanged(newColor, n) async {
    switch (n) {
      case 1:
        primaryColor = newColor;
        break;
      case 2:
        accentColor = newColor;
        break;
      case 3:
        primaryColor = newColor;
        accentColor = Colors.grey;
    }

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("primaryColor", primaryColor.value);
    prefs.setInt("accentColor", accentColor.value);
  }

  getThemeColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    primaryColor = Color(prefs.getInt("primaryColor") ?? 0xFF673AB7);
    accentColor = Color(prefs.getInt("accentColor") ?? 0xFF9E9E9E);
    notifyListeners();
  }

  Widget createRadio(ThemeMode value, String label) {
    return RadioListTile(
        title: Text(label),
        value: value,
        groupValue: tm,
        onChanged: (val) {
          themeModeChange(val);
        });
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    _getThemeText(tm);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeText", themeText);
  }

  showcolorpicker(BuildContext context, int n) {
    ColorPicker(
      color: accentColor,
      onColorChanged: (Color value) {
        onChanged(value, n);
      },
    ).showPickerDialog(context);
  }

  _getThemeText(ThemeMode tm) {
    if (tm == ThemeMode.dark)
      themeText = "d";
    else if (tm == ThemeMode.light)
      themeText = "l";
    else if (tm == ThemeMode.system) themeText = "s";
  }

  getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeText = prefs.getString("themeText") ?? "s";
    if (themeText == "d")
      tm = ThemeMode.dark;
    else if (themeText == "l")
      tm = ThemeMode.light;
    else if (themeText == "s") tm = ThemeMode.system;
    notifyListeners();
  }

  getData() {
    getThemeMode();
    getThemeColors();
  }
}
