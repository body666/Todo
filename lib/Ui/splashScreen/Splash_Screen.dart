import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Ui/layout/home_layout.dart';
import 'package:todo_app/Ui/login/login.dart';
import 'package:todo_app/Ui/screens/tasks/edit_task.dart';
import 'package:todo_app/providers/my_provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName="SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){

    super.initState();
    Timer(Duration(seconds: 2), SplashNavigator);
  }

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
    return Stack(
      children: [
        Image.asset("assets/images/Splash_Screen_light.png",
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(),

      ],
    );
  }
  SplashNavigator(){

    Navigator.pushNamedAndRemoveUntil(context,
       homeLayout.routeName,

        (route) => false);
  }

}
