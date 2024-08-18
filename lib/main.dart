import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Ui/splashScreen/Splash_Screen.dart';

import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/styles/theming.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Ui/layout/home_layout.dart';
import 'Ui/login/login.dart';
import 'Ui/screens/tasks/edit_task.dart';
import 'Ui/signUp/signUp.dart';
import 'data/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.enableNetwork(); // to make the project on local database
  runApp(ChangeNotifierProvider(
    create: (context) => MyProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  late MyProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyProvider>(context);
    initSharedPref();

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.local),
      themeMode: provider.themeMode,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute:
      provider.firebaseUser!=null?HomeLayout.routeName:
      SplashScreen.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        EditTask.routeName: (context) => EditTask(),
        LoginPage.routeName: (context) => LoginPage(),
        SignupPage.routeName: (context) => SignupPage(),
        SplashScreen.routeName: (context) => SplashScreen(),
      },
    );
  }

  void initSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String lang = prefs.getString("lang") ?? "en";
    String theme = prefs.getString("theme") ?? "dark";

    provider.ChangeLanguage(lang);

    if (theme == "light") {
      provider.ChangeTheme(ThemeMode.light);
    } else {
      provider.ChangeTheme(ThemeMode.dark);
    }
  }
}
