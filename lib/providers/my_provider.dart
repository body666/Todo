import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/user_model.dart';

import '../data/firebase/firebase_manager.dart';
class MyProvider extends ChangeNotifier{
  userModel? Usermodel;
  User? firebaseUser;


  String local="en";
  ThemeMode themeMode = ThemeMode.dark;

  MyProvider(){
    firebaseUser = FirebaseAuth.instance.currentUser;
     if(firebaseUser !=null)
       {
         initUser();
       }
  }



  ChangeLanguage(String langCode)async{
    local=langCode;
   final SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setString("lang", langCode);
    notifyListeners();

  }

  ChangeTheme(ThemeMode newTheme)async{
    themeMode=newTheme;
    final SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setString("theme", newTheme==ThemeMode.light?"light":"dark");
    notifyListeners();

  }


  initUser() async{
    firebaseUser=FirebaseAuth.instance.currentUser;
    Usermodel=await FirebaseManager.readUser(firebaseUser!.uid);
    notifyListeners();
  }

}