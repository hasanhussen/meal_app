import 'package:flutter/material.dart';
import 'package:meal/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../widget/drawer.dart';

class ThemeScreen extends StatelessWidget {
  static const route = '/ThemeScreen';
  final bool fromOnBoarding;
  const ThemeScreen({super.key, this.fromOnBoarding = false});

  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<ThemeProvider>(context);
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
                    lan.getTexts("theme_appBar_title").toString(),
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
          body: Column(children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lan.getTexts("theme_screen_title").toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            themeprovider.createRadio(ThemeMode.system,
                lan.getTexts("System_default_theme").toString()),
            themeprovider.createRadio(
                ThemeMode.light, lan.getTexts("light_theme").toString()),
            themeprovider.createRadio(
                ThemeMode.dark, lan.getTexts("dark_theme").toString()),
            const SizedBox(height: 15),
            ListTile(
              title: Text(lan.getTexts("primary").toString()),
              trailing: InkWell(
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .showcolorpicker(context, 1);
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
            ListTile(
              title: Text(lan.getTexts("accent").toString()),
              trailing: InkWell(
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .showcolorpicker(context, 2);
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).hintColor,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .onChanged(Colors.deepPurple, 3);
                },
                child: Text(lan.isEn
                    ? 'Reset a defult colors'
                    : 'استعادة الألوان الافتراضية')),
            SizedBox(height: fromOnBoarding ? 80 : 0)
          ]),
          drawer: fromOnBoarding ? null : const MyDrawer(),
        ));
  }
}
