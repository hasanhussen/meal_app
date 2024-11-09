import 'package:flutter/material.dart';
import 'package:meal/dummy_data.dart';
import 'package:meal/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegatarian': false,
    'vegan': false,
  };
  List<Meal> avilibleMeal = DUMMY_MEALS;
  List<String> prefsMealId = [];
  List<Meal> myFavorites = [];
  List<Category> availableCategory = [];

  void onchange(bool value, String filtername) {
    filters[filtername] = value;
    notifyListeners();
  }

  void myFilter() async {
    avilibleMeal = DUMMY_MEALS.where((element) {
      if (filters['gluten'] == true && element.isGlutenFree == false) {
        return false;
      }
      if (filters['lactose'] == true && element.isLactoseFree == false) {
        return false;
      }
      if (filters['vegetarian'] == true && element.isVegetarian == false) {
        return false;
      }
      if (filters['vegan'] == true && element.isVegan == false) {
        return false;
      } else {
        return true;
      }
    }).toList();

    List<Category> ac = [];
    for (var meal in avilibleMeal) {
      for (var catId in meal.categories) {
        for (var cat in DUMMY_CATEGORIES) {
          if (cat.id == catId) {
            if (!ac.any((cat) => cat.id == catId)) ac.add(cat);
          }
        }
      }
    }
    availableCategory = ac;

    List<Meal> fm = [];
    for (var favMeals in myFavorites) {
      for (var avMeals in avilibleMeal) {
        if (favMeals.id == avMeals.id) fm.add(favMeals);
      }
    }
    myFavorites = fm;

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten'] ?? false);
    prefs.setBool('lactose', filters['lactose'] ?? false);
    prefs.setBool('vegetarian', filters['vegetarian'] ?? false);
    prefs.setBool('vegan', filters['vegan'] ?? false);
  }

  void addRemoveMeal(id) async {
    final existeId = myFavorites.indexWhere((element) => element.id == id);
    if (existeId >= 0) {
      myFavorites.removeAt(existeId);
      prefsMealId.remove(id);
    } else {
      myFavorites.add(DUMMY_MEALS.firstWhere((element) => element.id == id));
      prefsMealId.add(id);
    }
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('prefsMealId', prefsMealId);
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegetarian'] = prefs.getBool('vegetarian') ?? false;
    filters['vegan'] = prefs.getBool('vegan') ?? false;

    prefsMealId = prefs.getStringList("prefsMealId") ?? [];
    for (var mealId in prefsMealId) {
      final existingIndex = myFavorites.indexWhere((meal) => meal.id == mealId);
      if (existingIndex < 0) {
        myFavorites.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }
    myFilter();
  }

  bool isMealFavorites(id) {
    bool isFavorites = myFavorites.any((element) => element.id == id);
    if (isFavorites) {
      return true;
    } else {
      return false;
    }
  }
}
