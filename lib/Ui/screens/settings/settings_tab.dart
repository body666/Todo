import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/styles/colors.dart';
import '../../../providers/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class settingsTab extends StatefulWidget {
  @override
  State<settingsTab> createState() => _settingsTabState();
}

class _settingsTabState extends State<settingsTab> {
  bool LangStatus = false;
  bool ThemeStatus = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var ScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                  height: ScreenSize.height * 0.157, color: Color(0xFF5D9CEC)),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  AppLocalizations.of(context)!.settings,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: provider.themeMode == ThemeMode.light
                          ? Colors.white
                          : primarydark),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Arabic (اللغه العربيه)",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Switch(
                      activeColor: provider.themeMode == ThemeMode.light?
                      Colors.blue:Colors.blue,
                      inactiveTrackColor: provider.themeMode == ThemeMode.light?
                      Colors.white:Colors.white,
                        value: LangStatus,
                        onChanged: (newValue) {
                          provider.local == "en"
                              ? provider.ChangeLanguage("ar")
                              : provider.ChangeLanguage("en");

                          setState(() {
                            LangStatus = newValue;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      AppLocalizations.of(context)!.theme,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    Switch(
                        activeColor: provider.themeMode == ThemeMode.light?
                        Colors.blue:Colors.blue,
                        inactiveTrackColor: provider.themeMode == ThemeMode.light?
                        Colors.white:Colors.white,
                        value: ThemeStatus,
                        onChanged: (newValue) {
                          provider.themeMode == ThemeMode.dark
                              ? provider.ChangeTheme(ThemeMode.light)
                              : provider.ChangeTheme(ThemeMode.dark);

                          setState(() {
                            ThemeStatus = newValue;
                          });
                        })
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
