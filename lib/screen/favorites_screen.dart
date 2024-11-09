import 'package:flutter/material.dart';
import 'package:meal/widget/meal_item.dart';
import 'package:provider/provider.dart';
import 'package:meal/providers/mealprovider.dart';

import '../models/meal.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isLandScape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    List<Meal> myFavoriter = Provider.of<MealProvider>(context).myFavorites;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw <= 400 ? 400 : 500,
          //childAspectRatio:isLandScape?dw/(dw*0.8) : dw/(dw*0.75),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0),
      itemBuilder: ((context, index) {
        return MealItem(
          id: myFavoriter[index].id,
          imageUrl: myFavoriter[index].imageUrl,
          duration: myFavoriter[index].duration,
          complexity: myFavoriter[index].complexity,
          affordability: myFavoriter[index].affordability,
        );
      }),
      itemCount: myFavoriter.length,
    );
  }
}
