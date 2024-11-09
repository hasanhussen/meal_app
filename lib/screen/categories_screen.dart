import 'package:flutter/material.dart';
import 'package:meal/widget/category_item.dart';
import 'package:provider/provider.dart';
import 'package:meal/providers/mealprovider.dart';

class Catogeries extends StatelessWidget {
  const Catogeries({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, crossAxisSpacing: 20, mainAxisSpacing: 20),
        children: Provider.of<MealProvider>(context)
            .availableCategory
            .map((e) => CategoryItem(id: e.id, color: e.color))
            .toList());
  }
}
