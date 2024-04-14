import 'package:flutter/material.dart';
import 'package:todo_app/shared/network/firebase/firebase_manager.dart';
import '../login/login.dart';

class SignupPage extends StatelessWidget {
  static const String routeName = "SignUp";
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var ConfirmPasswordController = TextEditingController();

  var _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Form(
              key: _formkey,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Create your account",
                        style: TextStyle(fontSize: 15, color: Colors.blue[700]),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.blue.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.person)),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.blue.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.person)),
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
                            return "Please enter valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          final bool passwordValid = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value);
                          if (!passwordValid) {
                            return "Please enter valid password";
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: ConfirmPasswordController,
                        validator: (value) {
                          if (passwordController.text != value) {
                            return "password doesn't match";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.blue.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            FirebaseManager.CreateAccount(
                                emailController.text,
                                passwordController.text,
                                usernameController.text,
                                () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  LoginPage.routeName, (route) => false);
                               } ,
                                    (error) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialog(
                                  title: Text("Error"),
                                  content: Text(error.toString()),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Okay"))
                                  ],
                                ),
                              );
                            });
                          }
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blueAccent,
                        ),
                      )),
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
                          color: Colors.white.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30.0,
                            width: 30.0,
                          ),
                          const SizedBox(width: 18),
                          const Text(
                            "Sign In with Google",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, LoginPage.routeName, (route) => false);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.blueAccent),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
