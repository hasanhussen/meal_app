import 'package:flutter/material.dart';
import 'package:meal/providers/homeprovider.dart';
import 'package:meal/providers/onboarding_provider.dart';
import 'package:meal/providers/theme_provider.dart';
import 'package:meal/screen/category_meals_screen.dart';
import 'package:meal/screen/filters_screen.dart';
import 'package:meal/screen/meal_detail_screen.dart';
import 'package:meal/screen/on_boarding_screen.dart';
import 'package:meal/screen/tabs_screen.dart';
import 'package:meal/screen/themescreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/mealprovider.dart';
import 'providers/language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homeScreen = (prefs.getBool('watched') ?? false)
      ? const TabScreen()
      : const OnBoardingScreen();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<MealProvider>(
          create: (_) => MealProvider()..getData()),
      ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider()..getData()),
      ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider()..getLan()),
      ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
      ChangeNotifierProvider<OnBoardingProvider>(
          create: (_) => OnBoardingProvider()),
    ], child: MyApp(homeScreen)),
  );
}

class MyApp extends StatelessWidget {
  final Widget homeScreen;
  const MyApp(this.homeScreen, {super.key});

  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal',
      themeMode: Provider.of<ThemeProvider>(context).tm,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
        hintColor: accentColor,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        useMaterial3: true,
        hintColor: accentColor,
      ),
      routes: {
        '/': (context) => homeScreen,
        TabScreen.routeName: (context) => const TabScreen(),
        Meals.routName: (context) => const Meals(),
        MealDetailScreen.route: (context) => const MealDetailScreen(),
        Filters.routeName: (context) => const Filters(),
        ThemeScreen.route: (context) => const ThemeScreen(),
      },
    );
  }
}
