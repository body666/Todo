import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';

import 'package:todo_app/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/firebase/firebase_manager.dart';
import '../../../providers/my_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var taskTitleController = TextEditingController();
  var taskDescriptionController = TextEditingController();
  var selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    // Convert TimeOfDay to 12-hour format with AM/PM
    String formattedTime = _formatTime(selectedTime);

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.addNewTask,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 25),
          TextFormField(
            cursorColor: Colors.blue,
            controller: taskTitleController,
            decoration: InputDecoration(
              label: Text(
                "Task title",
                style: TextStyle(
                    color: provider.themeMode == ThemeMode.light
                        ? Colors.black
                        : Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: primary, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: primary,
                  )),
            ),
          ),
          SizedBox(height: 25),
          TextFormField(
            cursorColor: Colors.blue,
            controller: taskDescriptionController,
            decoration: InputDecoration(
              label: Text(
                "Task description",
                style: TextStyle(
                    color: provider.themeMode == ThemeMode.light
                        ? Colors.black
                        : Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: primary, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: primary,
                  )),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context)!.selectDate,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              selectDate();
            },
            child: Text(
              selectedDate.toString().substring(0, 10),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: primary,
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context)!.selectTime,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              TimeOfDay? newTime = await showTimePicker(
                context: context,
                initialTime: selectedTime,
              );
              if (newTime == null) return;

              setState(() {
                selectedTime = newTime;
              });
            },
            child: Text(
              formattedTime,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: primary,
              ),
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              TaskModel task = TaskModel(
                title: taskTitleController.text,
                description: taskDescriptionController.text,
                date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
                time: selectedTime,  // Add the selected time
                userId: FirebaseAuth.instance.currentUser!.uid,
              );
              FirebaseManager.addTask(task);
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context)!.addTask,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  selectDate() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),

    );

    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    } else {
      // Handle the case when the user cancels the date picker
      print('Date selection was canceled');
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute $period";
  }
}