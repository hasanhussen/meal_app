import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal/providers/onboarding_provider.dart';
import 'package:meal/screen/themescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import './tabs_screen.dart';
import './filters_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage("images/image.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 300,
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Text(
                        lan.getTexts("drawer_name").toString(),
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Container(
                      width: 350,
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Text(
                            lan.getTexts('drawer_switch_title').toString(),
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  lan
                                      .getTexts('drawer_switch_item2')
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 25, color: Colors.white)),
                              const SizedBox(width: 5),
                              Switch(
                                value: lan.isEn,
                                onChanged: (newValue) {
                                  Provider.of<LanguageProvider>(context,
                                          listen: false)
                                      .changeLan(newValue);
                                },
                              ),
                              const SizedBox(width: 5),
                              Text(
                                  lan
                                      .getTexts('drawer_switch_item1')
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 25, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const ThemeScreen(fromOnBoarding: true),
              const Filters(fromOnBoarding: true),
            ],
            onPageChanged: (val) {
              Provider.of<OnBoardingProvider>(context, listen: false)
                  .onPageChanged(val);
            },
          ),
          Indicator(Provider.of<OnBoardingProvider>(context).currentIndex),
          Builder(
            builder: (ctx) => Align(
              alignment: const Alignment(0, 0.85),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    //padding: lan.isEn ? MaterialStateProperty.all(7 as EdgeInsetsGeometry?) : MaterialStateProperty.all(0 as EdgeInsetsGeometry?),
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                  ),
                  child: Text(lan.getTexts('start').toString(),
                      style: TextStyle(
                          color: useWhiteForeground(primaryColor)
                              ? Colors.white
                              : Colors.black,
                          fontSize: 25)),
                  onPressed: () async {
                    Navigator.of(ctx).pushReplacementNamed(TabScreen.routeName);

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('watched', true);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int index;

  const Indicator(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(context, 0),
          buildContainer(context, 1),
          buildContainer(context, 2),
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext ctx, int i) {
    return index == i
        ? Icon(Icons.star, color: Theme.of(ctx).primaryColor)
        : Container(
            margin: const EdgeInsets.all(4),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Theme.of(ctx).hintColor,
              shape: BoxShape.circle,
            ),
          );
  }
}
