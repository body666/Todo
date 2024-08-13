import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/styles/colors.dart';
abstract class BaseConnector{
  showMessage(String message);
  showLoading(String text);
  hideLoading();
}

class BaseViewModel<CON extends BaseConnector> extends ChangeNotifier{
  CON? connector;

}


abstract class BaseView<VM extends BaseViewModel,S extends StatefulWidget> extends State<S> implements BaseConnector{
 late VM viewModel;
 VM initViewModel();

  @override
  void initState(){
    super.initState();
    viewModel = initViewModel();
  }

  @override
  hideLoading() {
    Navigator.pop(context);
  }

  @override
  showLoading(String text) {
    var provider =Provider.of<MyProvider>(context,listen: false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:(context) =>  AlertDialog(
        backgroundColor: provider.themeMode==ThemeMode.light?primarylight: Color(0xFF0D1B2A),
        title: Center(child: CircularProgressIndicator(color: Colors.blueAccent,)),
      ),
    );

  }

  @override
  showMessage(String message) {
     var provider =Provider.of<MyProvider>(context,listen: false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:(context) => AlertDialog(
        backgroundColor: provider.themeMode==ThemeMode.light?Color(0xFFb4cabe): Color(0xFF0D1B2A),
        title: Directionality(
            textDirection: TextDirection.ltr,
             child: const Text("Error")),
        content: Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(message,style: TextStyle(fontSize: 16),),
            )),
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                onPressed: () {
              Navigator.pop(context);
            },
                child:Directionality(
                    textDirection: TextDirection.rtl,
                    child: const Text("Okay",style: TextStyle(color: Colors.white),)) ),
          )
        ],
      ),
    );
  }


}