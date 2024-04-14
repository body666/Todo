import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Ui/layout/home_layout.dart';
import 'package:todo_app/Ui/login/login_connector.dart';
import 'package:todo_app/Ui/login/login_vm.dart';
import 'package:todo_app/base.dart';
import 'package:todo_app/providers/my_provider.dart';
import '../signUp/signUp.dart';
class LoginPage extends StatefulWidget {
  static const String routeName = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseView<LoginViewModel,LoginPage>
    implements LoginConnector{
  LoginViewModel viewModel = LoginViewModel();

  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var _formkey=GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    viewModel.connector=this;
  }


  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
      return ChangeNotifierProvider(
      create: (context) => viewModel,
       builder: (context, child) =>  MaterialApp(
         debugShowCheckedModeBanner: false,
         home: Scaffold(
           body: Container(
             margin: const EdgeInsets.all(24),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 const Column(
                   children: [
                     Text("Welcome Back",
                       style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                     ),
                     Text("Enter your credential to login"),
                   ],
                 ),
                 Form(
                   key: _formkey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       TextFormField(
                         decoration: InputDecoration(
                             hintText: "Email",
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(18),
                                 borderSide: BorderSide.none
                             ),
                             fillColor: Colors.blue.withOpacity(0.1),
                             filled: true,
                             prefixIcon: const Icon(Icons.person)
                         ),
                         controller: emailController,
                         keyboardType: TextInputType.emailAddress,

                         validator: (value){
                           if( value==null || value.isEmpty)
                           {
                             return "Please enter your email";
                           }
                           final bool emailValid =
                           RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                               .hasMatch(value);
                           if(!emailValid)
                           {
                             return "Please enter valid email";
                           }
                           return null;

                         },
                       ),
                       const SizedBox(height: 10),
                       TextFormField(
                         decoration: InputDecoration(
                           hintText: "Password",
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(18),
                               borderSide: BorderSide.none),
                           fillColor: Colors.blue.withOpacity(0.1),
                           filled: true,
                           prefixIcon: const Icon(Icons.password),

                         ),
                         controller: passwordController,

                         validator: (value){
                           if( value==null || value.isEmpty)
                           {
                             return "Please enter your password";
                           }
                           final bool passwordValid =
                           RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                               .hasMatch(value);
                           if(!passwordValid)
                           {
                             return "Please enter valid password";
                           }
                           return null;

                         },
                         obscureText: true,
                       ),
                       const SizedBox(height: 10),
                       ElevatedButton(
                         onPressed: () {
                           if(_formkey.currentState!.validate()){
                             viewModel.Login(emailController.text, passwordController.text);
                           }
                         },
                         style: ElevatedButton.styleFrom(
                           shape: const StadiumBorder(),
                           padding: const EdgeInsets.symmetric(vertical: 16),
                           backgroundColor: Colors.blue,
                         ),
                         child: const Text(
                           "Login",
                           style: TextStyle(fontSize: 20),
                         ),
                       )
                     ],
                   ),
                 ),
                 TextButton(
                   onPressed: () {
                     //FirebaseAuth.instance.sendPasswordResetEmail(email:emailConteoller as String);
                   },
                   child: const Text("Forgot password?",
                     style: TextStyle(color: Colors.blue),
                   ),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const Text("Don't have an account? "),
                     TextButton(
                         onPressed: () {
                           Navigator.pushNamed(context, SignupPage.routeName);
                         },
                         child: const Text("Sign Up", style: TextStyle(color: Colors.blue),)
                     )
                   ],
                 ),

               ],
             ),
           ),
         ),
       ),

    );
  }

  @override
  goToHome() {
    var provider =Provider.of<MyProvider>(context);
      provider.initUser();
      Navigator.pushNamedAndRemoveUntil(context , homeLayout.routeName, (route) => false);

  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }





  // @override
  // hideLoading() {
  //   Navigator.pop(context);
  // }
  //
  // @override
  // showLoading(String text) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder:(context) => const AlertDialog(
  //       title: Center(child: CircularProgressIndicator()),
  //     ),);
  //
  // }
  //
  // @override
  // showMessage(String message) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder:(context) => AlertDialog(
  //       title: Text("Error"),
  //       content: Text(message),
  //       actions: [
  //         ElevatedButton(onPressed: () {
  //           Navigator.pop(context);
  //         },
  //             child:Text("Okay") )
  //       ],
  //     ),
  //   );
  // }



}










