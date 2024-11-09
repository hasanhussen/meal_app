import 'package:flutter/material.dart';
import 'package:meal/screen/filters_screen.dart';
import 'package:meal/screen/themescreen.dart';
import 'package:meal/providers/language_provider.dart';
import 'package:provider/provider.dart';

import '../screen/tabs_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 200,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Text(
                  lan.getTexts('drawer_name').toString(),
                  style: TextStyle(
                      fontSize: 35,
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 70),
              ListTile(
                leading: const Icon(
                  Icons.restaurant,
                  size: 40,
                ),
                title: Text(
                  lan.getTexts('drawer_item1').toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(TabScreen.routeName);
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  size: 40,
                ),
                title: Text(
                  lan.getTexts('drawer_item2').toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(Filters.routeName);
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.color_lens,
                  size: 40,
                ),
                title: Text(
                  lan.getTexts('drawer_item3').toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(ThemeScreen.route);
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.language_sharp,
                  size: 40,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(lan.getTexts("drawer_switch_item2").toString(),
                        style: const TextStyle(fontSize: 20)),
                    Switch(
                        value: lan.isEn,
                        onChanged: (newval) {
                          Provider.of<LanguageProvider>(context, listen: false)
                              .changeLan(newval);
                        }),
                    Text(lan.getTexts("drawer_switch_item1").toString(),
                        style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
