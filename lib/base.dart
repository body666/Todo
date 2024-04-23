import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  void initState() {
    super.initState();
    viewModel = initViewModel();
  }

  @override
  hideLoading() {
    Navigator.pop(context);
  }

  @override
  showLoading(String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:(context) => const AlertDialog(
        title: Center(child: CircularProgressIndicator()),
      ),
    );

  }

  @override
  showMessage(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:(context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          },
              child:const Text("Okay") )
        ],
      ),
    );
  }


}