// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/screen/meal_detail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class MealItem extends StatelessWidget {
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final String id;
  const MealItem(
      {super.key,
      required this.imageUrl,
      required this.duration,
      required this.complexity,
      required this.affordability,
      required this.id});

  @override
  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Container(
          width: isLandScape ? (dw * 0.5 - 30) : dw,
          margin: isLandScape
              ? const EdgeInsets.all(10)
              : const EdgeInsets.only(bottom: 1),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(MealDetailScreen.route, arguments: {'id': id});
                },
                child: Stack(
                  children: [
                    Hero(
                        tag: id,
                        child: ClipRRect(
                          child: InteractiveViewer(
                            child: FadeInImage.assetNetwork(
                                key: ValueKey(DateTime.now()),
                                placeholder: 'images/a2.png',
                                image: imageUrl,
                                height: isLandScape ? (dh * 0.6) : (dh * 0.3),
                                width: isLandScape ? (dw * 0.5 - 30) : dw,
                                fit: BoxFit.cover),
                          ),
                        )),
                    Positioned(
                        bottom: 20,
                        right: 10,
                        child: Container(
                            height: 100,
                            width: 260,
                            color: const Color.fromARGB(100, 71, 66, 66),
                            child: Text(
                              lan.getTexts("meal-$id").toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ))),
                  ],
                ),
              ),
              Container(
                height: 80,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(children: [
                        const Icon(Icons.access_alarm_sharp),
                        Text(
                            '$duration${lan.getTexts(duration <= 10 ? 'min2' : 'min')}')
                      ]),
                    ),
                    Container(
                      child: Row(children: [
                        const Icon(Icons.work),
                        Text(lan.getTexts('$complexity').toString())
                      ]),
                    ),
                    Container(
                      child: Row(children: [
                        const Icon(Icons.money),
                        Text(lan.getTexts('$affordability').toString())
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
