import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/styles/theming.dart';
import '../../providers/my_provider.dart';
import '../../styles/colors.dart';
import '../login/login.dart';
import '../screens/settings/settings_tab.dart';
import '../screens/tasks/AddTaskBottomSheet.dart';
import '../screens/tasks/tasks_Tab.dart';
class homeLayout extends StatefulWidget {
  static const String routeName="homeLayout";

  @override
  State<homeLayout> createState() => _homeLayoutState();
}

class _homeLayoutState extends State<homeLayout> {
  int selectedIndex=0;
  List<Widget>tabs=[tasksTab(),settingsTab()];

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true, // to show background of notched
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){
                showDialog(
                  context: context,
                  //barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: Text("Sign out"),
                    content: Text("Are you sure you want to sign out?"),
                    actions: [
                      ElevatedButton(onPressed: (){
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (route) => false);
                      }, child: Text("Yes")),
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("No"))
                    ],
                  ),
                );
          } ,
              icon: Icon(Icons.logout_outlined))
        ],
        backgroundColor: Color(0xFF5D9CEC),
        title: Text(" To Do List               ${provider.Usermodel?.username}",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
          ) ,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      FloatingActionButton(
          onPressed: (){
          ShowTaskBottomSheet();
          },
          backgroundColor: Colors.blue,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide:  BorderSide(
               color: provider.themeMode==ThemeMode.light?Colors.white:const Color(0xFF141922),
                width: 5,

            )
          ),
      child: Icon(Icons.add,size: 30,color: Colors.white,)
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex:selectedIndex ,
            onTap: (value){
            setState(() {
              selectedIndex=value;
            });
            },
            items:  const [
              BottomNavigationBarItem(icon:Icon(Icons.list,size: 30,),label: ""),
              BottomNavigationBarItem(icon:Icon(Icons.settings,size: 30,),label: ""),
            ]
        ),
      ),
      body: tabs[selectedIndex],

    );
  }
  ShowTaskBottomSheet(){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
       return Padding(
         padding: EdgeInsets.only(
             bottom: MediaQuery.of(context).viewInsets.bottom),
           child: AddTaskBottomSheet());
     },
    );
  }

}
