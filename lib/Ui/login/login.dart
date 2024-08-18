import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Ui/layout/home_layout.dart';
import 'package:todo_app/Ui/login/login_connector.dart';
import 'package:todo_app/views_model/login_vm.dart';
import 'package:todo_app/base.dart';
import 'package:todo_app/providers/my_provider.dart';
import '../../styles/colors.dart';
import '../signUp/signUp.dart';
class LoginPage extends StatefulWidget {
  static const String routeName = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseView<LoginViewModel,LoginPage> implements LoginConnector{
  LoginViewModel viewModel = LoginViewModel();

  var _formkey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();


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
           backgroundColor:provider.themeMode==ThemeMode.light?primarylight: Color(0xFF0D1B2A),
           body: Container(
             color: provider.themeMode==ThemeMode.light?primarylight: Color(0xFF0D1B2A),
             margin: const EdgeInsets.all(24),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                  Column(
                   children: [
                     Text("Welcome Back",
                       style: TextStyle(
                         fontSize: 40,
                           fontWeight: FontWeight.bold,
                           color:provider.themeMode==ThemeMode.light?Colors.blue: Colors.white,
                       ),
                     ),
                     Text("Enter your credential to login",style: TextStyle(color: Colors.blue[700]),),
                   ],
                 ),
                 Form(
                   key: _formkey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       TextFormField(
                         style: TextStyle( color:provider.themeMode==ThemeMode.light?Colors.black: Colors.white,),
                         decoration: InputDecoration(
                             hintText: "Email",
                             hintStyle: TextStyle(
                                 color:provider.themeMode==ThemeMode.light? Color(0xFF505A58):Colors.white,
                             ),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(18),
                                 borderSide: BorderSide.none
                             ),
                             fillColor: Colors.blue.withOpacity(0.1),
                             filled: true,
                             prefixIcon: const Icon(
                               Icons.person, color: Color(0xFF4389FD)
                             )
                         ),
                         controller: emailController,
                         keyboardType: TextInputType.emailAddress,
                         cursorColor:provider.themeMode==ThemeMode.light? Colors.white:Colors.purple ,
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
                         style: TextStyle(
                           color:provider.themeMode==ThemeMode.light?Colors.black: Colors.white,
                         ),
                         decoration: InputDecoration(
                           hintText: "Password",
                           hintStyle: TextStyle( color:provider.themeMode==ThemeMode.light? Color(0xFF505A58):Colors.white,
                           ),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(18),
                               borderSide: BorderSide.none),
                           fillColor: Colors.blue.withOpacity(0.1),
                           filled: true,
                           prefixIcon: const Icon(Icons.password,color:Color(0xFF4389FD)),

                         ),
                         controller: passwordController,
                         cursorColor:provider.themeMode==ThemeMode.light? Colors.white:Colors.purple ,
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
                           if(_formkey.currentState!.validate() ){
                             provider.initUser();
                             viewModel.Login(emailController.text,passwordController.text);
                           }

                         },
                         style: ElevatedButton.styleFrom(
                           shape: const StadiumBorder(),
                           padding: const EdgeInsets.symmetric(vertical: 16),
                           backgroundColor: Colors.blueAccent,
                         ),
                         child: const Text(
                           "Login",
                           style: TextStyle(fontSize: 20,color: Colors.white),
                         ),
                       )
                     ],
                   ),
                 ),
                 TextButton(
                   onPressed: () {
                     FirebaseAuth.instance.sendPasswordResetEmail(email:emailController as String);
                   },
                   child:  Text("Forgot password?",
                     style: TextStyle(color: Colors.blue[700]),
                   ),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                      Text("Don't have an account? ",
                       style: TextStyle( color:provider.themeMode==ThemeMode.light?Colors.blue: Colors.white,),),
                     TextButton(
                         onPressed: () {
                           Navigator.pushNamed(context, SignupPage.routeName);
                         },
                         child:  Text("Sign Up", style: TextStyle(color: Colors.blue[700]),)
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
     Navigator.pushNamedAndRemoveUntil(context , HomeLayout.routeName, (route) => false);
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }


}










