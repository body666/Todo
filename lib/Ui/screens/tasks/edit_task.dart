import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../models/task_model.dart';
import '../../../providers/my_provider.dart';
import '../../../shared/network/firebase/firebase_manager.dart';
import '../../../styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class EditTask extends StatefulWidget {
  static const String routeName="EditTask";
  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var selectedDate=DateTime.now();


late TaskModel task;
  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
    task=ModalRoute.of(context)!.settings.arguments as TaskModel;
    var ScreenSize= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title??"",
        style:
        TextStyle(color: provider.themeMode==ThemeMode.light?
       onSecondarylight:onSecondarydark)),
        ),
      body: Stack(
        children: [
          Container(height: ScreenSize.height*0.157,color: Color(0xFF5D9CEC)),
          SingleChildScrollView(
            child: Container(

              padding: EdgeInsets.all(ScreenSize.width*0.03),
              margin: EdgeInsets.symmetric(horizontal: ScreenSize.width*0.1,vertical: ScreenSize.height*0.05),
              height: ScreenSize.height*0.65,
              width: ScreenSize.width*0.90,
              decoration: BoxDecoration(
                  color: provider.themeMode==ThemeMode.light? Colors.white:Color(0xFF141922),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                children: [
                  Text(AppLocalizations.of(context)!.editTask,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 25,),
                  TextFormField(
                    cursorColor: Colors.blue,
                    initialValue: task.title,
                    onChanged: (value) {
                      task.title=value;
                    },
                    decoration: InputDecoration(
                        label: Text("Task title",
                          style: TextStyle(color: provider.themeMode==ThemeMode.light? Colors.black:Colors.white),
                          ),
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
                    initialValue: task.description,
                    onChanged: (value) {
                      task.description=value;
                    },
                    decoration: InputDecoration(
                        label: Text("Task description",
                          style: TextStyle(color: provider.themeMode==ThemeMode.light? Colors.black:Colors.white),),
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
                      ),),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      selectDate();

                    },
                    child: Text(selectedDate.toString().substring(0,10),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: primary
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 80),
                      ),
                      onPressed: () {
                        FirebaseManager.editTask(task);
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context)!.saveChanges,
                        style: TextStyle(color: Colors.white),)
                  ),
                ],
              ),
            ),
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
