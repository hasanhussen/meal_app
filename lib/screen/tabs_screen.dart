import 'package:flutter/material.dart';
import 'package:meal/providers/homeprovider.dart';
import 'package:meal/providers/language_provider.dart';
import 'package:meal/screen/categories_screen.dart';
import 'package:meal/screen/favorites_screen.dart';
import 'package:meal/widget/drawer.dart';
import 'package:provider/provider.dart';

class TabScreen extends StatelessWidget {
  static const routeName = '/tab';

  const TabScreen();

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    late List<Map<String, Object>> pages = [
      {'title': lan.getTexts("categories")!, 'page': Catogeries()},
      {'title': lan.getTexts("your_favorites")!, 'page': Favorites()},
    ];

    var homeprovider = Provider.of<HomeProvider>(context);
    return Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  pages[homeprovider.selectPage]['title'] as String,
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              body: pages[homeprovider.selectPage]['page'] as Widget,
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.category),
                      label: lan.getTexts("categories").toString()),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.star),
                      label: lan.getTexts("your_favorites").toString())
                ],
                selectedItemColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                currentIndex: homeprovider.selectPage,
                onTap: homeprovider.changpage,
              ),
              drawer: MyDrawer(),
            )));
  }
}
