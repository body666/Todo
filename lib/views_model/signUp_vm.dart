import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/Ui/signUp/signUp_connector.dart';
import 'package:todo_app/base.dart';
import '../data/firebase/firebase_manager.dart';
import '../models/user_model.dart';
class SignUpViewModel extends BaseViewModel<SignUpConnector>{
  Future<void> CreateAccount
      (String email,String password,String username)async {
    try  {
      connector!.showLoading("");
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
      userModel UserModel=userModel(email: email, id: credential.user!.uid, username:username);
      FirebaseManager.addUser(UserModel);
      connector!.hideLoading();
      connector!.goToLogin();

    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        connector!.showMessage(e.message.toString());
      } else if (e.code == 'email-already-in-use') {
       connector!.showMessage(e.code.toString());
      }
    } catch (e) {
      print(e);
    }
  }
}
