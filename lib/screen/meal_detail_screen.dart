import 'package:flutter/material.dart';
import 'package:meal/widget/meals.dart';
import 'package:provider/provider.dart';
import 'package:meal/providers/mealprovider.dart';

import '../providers/language_provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const route = '/MealDetailScreen';

  const MealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    String mealId = routeArg['id'] as String;
    List myMeal = Provider.of<MealProvider>(context)
        .avilibleMeal
        .where(
          (element) => element.id == mealId,
        )
        .toList();
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(lan.getTexts("meal-$mealId").toString(),
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.bold)),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return MealDetails(
                image: myMeal[index].imageUrl,
                id: mealId,
              );
            },
            itemCount: myMeal.length,
          ),
          floatingActionButton: FloatingActionButton(
            child: Provider.of<MealProvider>(context, listen: false)
                    .isMealFavorites(mealId)
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border),
            onPressed: () {
              Provider.of<MealProvider>(context, listen: false)
                  .addRemoveMeal(mealId);
            },
          ),
        ));
  }
}
