import 'package:flutter/material.dart';
import 'package:meal/screen/category_meals_screen.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final Color color;
  const CategoryItem({super.key, required this.id, required this.color});

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: InkWell(
          splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.of(context).pushNamed(Meals.routName, arguments: {
              'id': id,
            });
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.7),
                  color,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              lan.getTexts('cat-$id').toString(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
        ));
  }
}
