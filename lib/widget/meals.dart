import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class MealDetails extends StatefulWidget {
  final String id;
  final String image;
  const MealDetails({super.key, required this.image, required this.id});

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  @override
  Widget build(BuildContext context) {
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var lan = Provider.of<LanguageProvider>(context);
    List<String> ingli =
        lan.getTexts("ingredients-${widget.id}") as List<String>;
    List<String> stpli = lan.getTexts("steps-${widget.id}") as List<String>;
    var ing = Column(
      children: [
        Text(
          lan.getTexts('Ingredients').toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: isLandScape ? (dh * 0.5) : (dh * 0.25),
          width: isLandScape ? (dw * 0.5 - 15) : dw,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(10),
                color: Colors.amber,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    ingli[index],
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              );
            },
            itemCount: ingli.length,
          ),
        ),
      ],
    );
    var stp = Column(
      children: [
        Text(lan.getTexts('Steps').toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: isLandScape ? (dh * 0.5) : (dh * 0.25),
          width: isLandScape ? (dw * 0.5 - 30) : dw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                  leading: CircleAvatar(
                    child: Text('#${index + 1}'),
                  ),
                  title: Text(
                    stpli[index],
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ));
            },
            itemCount: stpli.length,
          ),
        ),
      ],
    );
    return Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Column(
          children: [
            Hero(
                tag: widget.id,
                child: InteractiveViewer(
                  child: FadeInImage.assetNetwork(
                    key: ValueKey(DateTime.now()),
                    placeholder: 'images/a2.png',
                    image: widget.image,
                    fit: BoxFit.cover,
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ing,
                  const SizedBox(
                    width: 15,
                  ),
                  stp
                ],
              ),
            if (!isLandScape) ing,
            if (!isLandScape)
              const SizedBox(
                height: 15,
              ),
            if (!isLandScape) stp
          ],
        ));
  }
}
