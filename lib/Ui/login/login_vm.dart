import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/Ui/login/login_connector.dart';
import 'package:todo_app/base.dart';
class LoginViewModel extends BaseViewModel<LoginConnector> {

  Future<void> Login(String email,String password) async {
    try {
      connector!.showLoading("");
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      connector!.hideLoading();
      connector!.goToHome();
      // if(credential.user!.emailVerified)
      // {
      //   //OnSuccess();
      // }
      //
      // else
      // {
      // //  OnError("Please verify your mail");
      // }

    } on FirebaseAuthException catch (e) {
      connector!.hideLoading();
      connector!.showMessage("Wrong email or password");
     // OnError("Wrong Mail or password");
      // if(e.code == "The supplied auth credential is incorrect, malformed or has expired.")
      //   {
      //
      //   }


      // if (e.code == 'user-not-found') {
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      // }
    }
  }
  


}