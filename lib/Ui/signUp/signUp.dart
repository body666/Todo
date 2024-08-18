import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Ui/signUp/signUp_connector.dart';
import 'package:todo_app/views_model/signUp_vm.dart';
import 'package:todo_app/base.dart';
import '../../data/firebase/firebase_manager.dart';
import '../../providers/my_provider.dart';
import '../../styles/colors.dart';
import '../login/login.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = "SignUp";

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends BaseView<SignUpViewModel,SignupPage> implements SignUpConnector{
  SignUpViewModel signUpViewModel =SignUpViewModel();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    viewModel.connector=this;
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor:provider.themeMode==ThemeMode.light?primarylight: Color(0xFF0D1B2A),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Create your account",
                      style: TextStyle(fontSize: 15, color: Colors.blue[700]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextFormField(
                        style: TextStyle(color:provider.themeMode==ThemeMode.light?Colors.black: Colors.white,),
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.blue.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.person,color: Color(0xFF4389FD),),
                        ),
                        cursorColor:provider.themeMode==ThemeMode.light? Colors.white:Colors.purple ,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextFormField(
                        style: TextStyle( color:provider.themeMode==ThemeMode.light?Colors.black: Colors.white,),
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.blue.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.email,color: Color(0xFF4389FD),),
                        ),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        cursorColor:provider.themeMode==ThemeMode.light? Colors.white:Colors.purple ,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextFormField(
                        style: TextStyle( color:provider.themeMode==ThemeMode.light?Colors.black: Colors.white,),
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.blue.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.password,color: Color(0xFF4389FD),),
                        ),
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          final bool passwordValid = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value);
                          if (!passwordValid) {
                            return "Password must be at least 8 characters long and include an uppercase letter, a number, and a special character.";
                          }
                          return null;
                        },
                        obscureText: true,
                        cursorColor:provider.themeMode==ThemeMode.light? Colors.white:Colors.purple ,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextFormField(
                        style: TextStyle( color:provider.themeMode==ThemeMode.light?Colors.black: Colors.white,),
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (passwordController.text != value) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.blue.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.password,color: Color(0xFF4389FD),),
                        ),
                        obscureText: true,
                        cursorColor:provider.themeMode==ThemeMode.light? Colors.white:Colors.purple ,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        provider.initUser();
                        viewModel.CreateAccount(emailController.text, passwordController.text, usernameController.text);
                      }
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ),
                const Center(child: Text("Or")),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.blueAccent,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent,
                        spreadRadius: 1,
                        blurRadius: 1,
                         offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            height: 30.0,
                            width: 30.0,
                            child: Image.asset('assets/images/icons8-google-48.png'), // Assuming you have a Google logo asset
                          ),
                        ),
                        const SizedBox(width: 18),
                        const Text(
                          "Sign In with Google",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Directionality(
                      textDirection: TextDirection.ltr,
                        child: const Text("Already have an account?")),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginPage.routeName,
                                (route) => false,
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color:Colors.blueAccent),
                        ),
                      ),
                    ),
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
  goToLogin() {
    Navigator.pushNamedAndRemoveUntil(context,LoginPage.routeName, (route) => false);
  }

  @override
  SignUpViewModel initViewModel() {
    return SignUpViewModel();
  }
}
