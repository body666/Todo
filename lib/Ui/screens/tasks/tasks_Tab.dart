import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Ui/screens/tasks/tasks_item.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/shared/network/firebase/firebase_manager.dart';

class tasksTab extends StatefulWidget {
  @override
  State<tasksTab> createState() => _tasksTabState();
}

class _tasksTabState extends State<tasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var ScreenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
         Container(height: ScreenSize.height * 0.157, color: Color(0xFF5D9CEC),),
         SizedBox(height: 15,),
         Column(
          children: [
            CalendarTimeline(
              initialDate: selectedDate,
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateSelected: (date) {
                selectedDate = date;
                setState(() {});
              },
              leftMargin: 20,
              monthColor: Colors.white,
              dayColor: Colors.white,
              activeDayColor: Colors.blue,
              activeBackgroundDayColor: Colors.white,
              dotsColor: Colors.blue,
              selectableDayPredicate: (date) => true,
              locale: 'en_ISO',
            ), //package
            SizedBox(height: 40),
            Expanded(
                child: StreamBuilder<QuerySnapshot<TaskModel>>(
                    stream: FirebaseManager.getTasks(selectedDate),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }
                      var tasks = snapshot.data?.docs
                              .map((doc) => doc.data())
                              .toList() ??
                          [];
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return tasksItem(tasks[index]);
                        },
                        itemCount: tasks.length,
                      );
                    }))
          ],
        )
        ],
    );
  }
}
