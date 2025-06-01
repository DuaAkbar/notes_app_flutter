import 'package:crudapp/screens/Register.dart';
import 'package:crudapp/screens/forgetpassword.dart';
import 'package:crudapp/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
            text: "FlutterFire",

            children: [
              TextSpan(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                text: "CRUD",
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF404A58)),
                  ),
                  hintText: "Enter Your Email",
                ),
                maxLines: 1,
                minLines: 1,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF404A58)),
                  ),
                  hintText: "Enter Your Password",
                ),
                obscureText: true,
                maxLines: 1,
                minLines: 1,
              ),
            ),

            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: "Forgot Password?",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder:
                                (context) =>
                                    Forgetpassword(), // replace with ForgotPassword() when ready
                          ),
                        );
                      },
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 60),
                ),
                onPressed: () async {
                  String email = emailcontroller.text;
                  String password = passwordcontroller.text;
                  String scaffoldMessengerMsg = "";
                  if (email.trim().isNotEmpty && password.trim().isNotEmpty) {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      scaffoldMessengerMsg = "Logged In Successfully!";
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(builder: (context) => Homepage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      scaffoldMessengerMsg = e.message!;
                    }
                  } else {
                    scaffoldMessengerMsg = "Email and Password both Required";
                  }

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(scaffoldMessengerMsg)));
                },
                child: Text("Login", style: TextStyle(fontSize: 18)),
              ),
            ),

            SizedBox(height: 20),

            Text.rich(
              TextSpan(
                text: "Don't have an account?",
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: "Sign In",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
