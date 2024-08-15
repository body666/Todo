import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/styles/colors.dart';
import '../../providers/my_provider.dart';
import '../login/login.dart';
import '../screens/settings/settings_tab.dart';
import '../screens/tasks/AddTaskBottomSheet.dart';
import '../screens/tasks/tasks_Tab.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "homeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;
  List<Widget> tabs = [tasksTab(), settingsTab()];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.ltr, // Set directionality to RTL
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    backgroundColor: provider.themeMode == ThemeMode.light
                        ? Color(0xFFb4cabe)
                        : Color(0xFF0D1B2A),
                    title: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text("Sign out", style: TextStyle(color: Colors.blue))),
                    content: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text("Are you sure you want to sign out?",
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                    actions: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: provider.themeMode == ThemeMode.light
                                  ? mintGreen
                                  : primarydark),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushNamedAndRemoveUntil(
                                context, LoginPage.routeName, (route) => false);
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: provider.themeMode == ThemeMode.light
                                  ? mintGreen
                                  : primarydark),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.logout_outlined),
            ),
          ],
          backgroundColor: provider.themeMode == ThemeMode.light
              ? secondarylight
              : Color(0xFF5C9BEA),
          title: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: [
                Text(
                  "To Do List",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 65),
                Text(
                  "${provider.Usermodel?.username}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.transparent,
          onPressed: () {
            showTaskBottomSheet();
          },
          backgroundColor: Colors.blue,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: provider.themeMode == ThemeMode.light
                  ? Colors.white
                  : const Color(0xFF141922),
              width: 4,
            ),
          ),
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 8,
          padding: const EdgeInsets.all(0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              currentIndex: selectedIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list_outlined,
                      size: 30,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    label: '')
              ]),
        ),
        body: SafeArea(
          child: tabs[selectedIndex],
        ),
      ),
    );
  }

  void showTaskBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddTaskBottomSheet(),
        );
      },
    );
  }
}
// abdalrahmanfekry2@gmail.com
// body@gmail.com
// aaaAAA2@