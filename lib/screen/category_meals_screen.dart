import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/widget/meal_item.dart';
import 'package:provider/provider.dart';
import 'package:meal/providers/mealprovider.dart';

import '../providers/language_provider.dart';

class Meals extends StatelessWidget {
  static const routName = '/Meals()';
  const Meals({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isLandScape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    // var dh = MediaQuery.of(context).size.height;
    var dw = MediaQuery.of(context).size.width;
    final routeArg =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    String? catId = routeArg['id'];
    List<Meal> categorymeal =
        Provider.of<MealProvider>(context).avilibleMeal.where(
      (meal) {
        return meal.categories.contains(catId);
      },
    ).toList();
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              lan.getTexts("cat-$catId").toString(),
              style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: dw <= 400 ? 400 : 500,
                //childAspectRatio:isLandScape?dw/(dw*0.8) : dw/(dw*0.75),
                crossAxisSpacing: 0,
                mainAxisSpacing: 0),
            itemBuilder: ((context, index) {
              return MealItem(
                id: categorymeal[index].id,
                imageUrl: categorymeal[index].imageUrl,
                duration: categorymeal[index].duration,
                complexity: categorymeal[index].complexity,
                affordability: categorymeal[index].affordability,
              );
            }),
            itemCount: categorymeal.length,
          ),
        ));
  }
}
