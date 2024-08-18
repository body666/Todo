import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/Ui/login/login_connector.dart';
import 'package:todo_app/base.dart';
class LoginViewModel extends BaseViewModel<LoginConnector> {
  Future<void> Login(String email,String password) async {
    try {
      connector!.showLoading("");
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      if (credential.user != null) {
        if (credential.user!.emailVerified) {
          connector!.hideLoading();
          connector!.goToHome();
        } else {
          connector!.hideLoading();
          connector!.showMessage("Please verify your email first");

        }
      }


    } on FirebaseAuthException catch (e) {
      connector!.hideLoading();
      connector!.showMessage("Wrong email or password");

    }
  }


}