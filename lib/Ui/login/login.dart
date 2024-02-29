import 'package:flutter/material.dart';
import 'package:todo_app/Ui/layout/home_layout.dart';
import 'package:todo_app/shared/network/firebase/firebase_manager.dart';
import '../signUp/signUp.dart';
class LoginPage extends StatelessWidget {

  static const String routeName="LoginPage";

  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  var _formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context) {
    return Form(
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
                FirebaseManager.Login(
                    emailController.text,
                    passwordController.text,
                        (){
                         // var provider =Provider.of<MyProvider>(context);
                         //  provider.initUser();
                         Navigator.pushNamedAndRemoveUntil(context,homeLayout.routeName, (route) => false);
                        },
                        (error){
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                              title: Text("Error"),
                              content: Text(error.toString()),
                              actions: [
                                ElevatedButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("Okay"))
                              ],
                            ),
                          );
                        },
                );
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
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        //FirebaseAuth.instance.sendPasswordResetEmail(email:emailConteoller as String);
      },
      child: const Text("Forgot password?",
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  _signup(context) {
    return Row(
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
    );
  }
}
