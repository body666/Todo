import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Ui/layout/home_layout.dart';
import 'package:todo_app/Ui/login/login.dart';
import '../../providers/my_provider.dart';
class SplashScreen extends StatefulWidget{
  static const String routeName="SplashScreen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return  Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(provider.themeMode==ThemeMode.light?
              "assets/images/Splash_Screen_light.png":
              "assets/images/Splash_Screen_dark.png",fit: BoxFit.cover,width:double.infinity,),
            )
          ],
        ),
      ),
    );
  }
}