import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';

import 'package:todo_app/styles/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../data/firebase/firebase_manager.dart';
import '../../../providers/my_provider.dart';
import 'edit_task.dart';

class tasksItem extends StatelessWidget {
  final TaskModel task;
  tasksItem(this.task);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    // Format TimeOfDay to 12-hour format with AM/PM if it is not null
    String formattedTime = task.time != null ? _formatTime(task.time!) : 'No Time Set';

    return Card(
      color: provider.themeMode == ThemeMode.light ? Colors.white : const Color(0xFF141922),
      elevation: 15,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
              onPressed: (context) {
                FirebaseManager.deleteTask(task.id);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(context, EditTask.routeName, arguments: task);
              },
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 80,
                width: 4,
                decoration: BoxDecoration(
                  color: task.isDone ? Colors.green : primary,
                  borderRadius: BorderRadius.circular(27),
                  border: Border.all(color: Colors.blue),
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: task.isDone ? Colors.green : primary,
                    ),
                  ),
                  Text(
                    task.description,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: provider.themeMode == ThemeMode.light ? Colors.black : Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.alarm, color: provider.themeMode == ThemeMode.light ? Colors.blueAccent : Colors.blueAccent),
                      SizedBox(width: 5),
                      Text(
                        formattedTime, // Display the formatted time here
                        style: TextStyle(
                          color: provider.themeMode == ThemeMode.light ? Colors.blueAccent : Colors.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  task.isDone = true;
                  FirebaseManager.updateTask(task);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: task.isDone ? Colors.green : primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: task.isDone
                      ? Center(
                        child: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  )
                      : Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute $period";
  }
}
