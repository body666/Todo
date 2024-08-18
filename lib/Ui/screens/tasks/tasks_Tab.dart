import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Ui/screens/tasks/tasks_item.dart';
import 'package:todo_app/models/task_model.dart';

import 'package:todo_app/styles/colors.dart';

import '../../../data/firebase/firebase_manager.dart';
import '../../../providers/my_provider.dart';

class tasksTab extends StatefulWidget {
  @override
  State<tasksTab> createState() => _tasksTabState();
}

class _tasksTabState extends State<tasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<MyProvider>(context, listen: false);
    return Stack(
      children: [
        Container(
          height: screenSize.height * 0.157,
          color: Color(0xFF5D9CEC),
        ),
        SizedBox(height: 15),
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
              monthColor: Color(0xFF2F4757),
              dayColor: Colors.white,
              activeDayColor: Colors.blue,
              activeBackgroundDayColor: Colors.white,
              dotColor: Colors.blue,
              selectableDayPredicate: (date) => true,
              locale: provider.local == "en" ? 'en_ISO' : 'ar',
            ),
            SizedBox(height: 40),
            Expanded(
              child: StreamBuilder<QuerySnapshot<TaskModel>>(
                stream: FirebaseManager.getTasks(selectedDate),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    print('Error fetching tasks: ${snapshot.error}');
                    return Center(child: Text("Something went wrong: ${snapshot.error}"));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    print('No tasks found for the selected date: $selectedDate');
                    return Center(child: Text("No tasks found for this date."));
                  }
                  var tasks = snapshot.data!.docs.map((doc) => doc.data()).toList();
                  print('Fetched ${tasks.length} tasks');
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return tasksItem(tasks[index]);
                    },
                    itemCount: tasks.length,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
