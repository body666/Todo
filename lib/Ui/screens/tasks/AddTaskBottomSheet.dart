
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/shared/network/firebase/firebase_manager.dart';
import 'package:todo_app/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/my_provider.dart';
class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var TaskTitleControllrer=TextEditingController();
  var TaskDescriptionControllrer=TextEditingController();
  var selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.addNewTask,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
            fontSize: 20,
              fontWeight: FontWeight.w700,
           ),
          ),
          SizedBox(height: 25,),
          TextFormField(
            cursorColor: Colors.blue,
            controller: TaskTitleControllrer,
            decoration: InputDecoration(
              label: Text("Task title",style: TextStyle(color: provider.themeMode==ThemeMode.light? Colors.black:Colors.white),),
              enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(15),
                 borderSide:BorderSide(
                   color: primary,
                   width: 2
                 )
              ),
              focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:BorderSide(
                    color: primary,
                  )
              )

            ),
          ),
          SizedBox(height: 25,),
          TextFormField(
            cursorColor: Colors.blue,
            controller: TaskDescriptionControllrer,
            decoration: InputDecoration(
                label: Text("Task description",style: TextStyle(color: provider.themeMode==ThemeMode.light? Colors.black:Colors.white),),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:BorderSide(
                      color: primary,
                        width: 2
                    )
                ),
                focusedBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:BorderSide(
                      color: primary,
                    )
                )

            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(AppLocalizations.of(context)!.selectDate,
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
            child: Text(selectedDate.toString().substring(0,10),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue
            ),
              onPressed: () {
             TaskModel task=TaskModel(title:TaskTitleControllrer.text,
                description: TaskDescriptionControllrer.text,
                date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
               userId: FirebaseAuth.instance.currentUser!.uid
             );
            FirebaseManager.addTask(task);
             Navigator.pop(context);
          },
              child: Text(AppLocalizations.of(context)!.addTask,style: TextStyle(color: Colors.white),)
          )
        ],
      ),
    );
  }

  selectDate()async{
   DateTime? choosenDate= await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
         selectedDate=choosenDate!;
        setState(() {
        });
  }
}
