import 'package:flutter/material.dart';
import 'package:meal/widget/drawer.dart';
import 'package:provider/provider.dart';
import 'package:meal/providers/mealprovider.dart';

import '../providers/language_provider.dart';

class Filters extends StatelessWidget {
  static const routeName = '/filters';
  final bool fromOnBoarding;
  const Filters({super.key, this.fromOnBoarding = false});

  @override
  Widget build(BuildContext context) {
    Map<String, bool> filters = Provider.of<MealProvider>(context).filters;
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: fromOnBoarding
              ? AppBar(
                  backgroundColor: Theme.of(context).canvasColor,
                  elevation: 0,
                )
              : AppBar(
                  title: Text(
                    lan.getTexts("filters_appBar_title").toString(),
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  actions: [
                    IconButton(
                        onPressed: () {
                          Provider.of<MealProvider>(context, listen: false)
                              .myFilter();
                        },
                        icon: const Icon(Icons.save))
                  ],
                ),
          body: Column(children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lan.getTexts("filters_screen_title").toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SwitchListTile(
                title: Text(lan.getTexts("Gluten-free").toString()),
                subtitle: Text(lan.getTexts("Gluten-free-sub").toString()),
                value: filters['gluten']!,
                onChanged: (value) {
                  Provider.of<MealProvider>(context, listen: false)
                      .onchange(value, 'gluten');
                }),
            SwitchListTile(
                title: Text(lan.getTexts("Lactose-free").toString()),
                subtitle: Text(lan.getTexts("Lactose-free_sub").toString()),
                value: filters['lactose']!,
                onChanged: (value) {
                  Provider.of<MealProvider>(context, listen: false)
                      .onchange(value, 'lactose');
                }),
            SwitchListTile(
                title: Text(lan.getTexts("Vegetarian").toString()),
                subtitle: Text(lan.getTexts("Vegetarian-sub").toString()),
                value: filters['vegatarian']!,
                onChanged: (value) {
                  Provider.of<MealProvider>(context, listen: false)
                      .onchange(value, 'vegatarian');
                }),
            SwitchListTile(
                title: Text(lan.getTexts("Vegan").toString()),
                subtitle: Text(lan.getTexts("Vegan-sub").toString()),
                value: filters['vegan']!,
                onChanged: (value) {
                  Provider.of<MealProvider>(context, listen: false)
                      .onchange(value, 'vegan');
                }),
            SizedBox(height: fromOnBoarding ? 80 : 0)
          ]),
          drawer: fromOnBoarding ? null : const MyDrawer(),
        ));
  }
}
