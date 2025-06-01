import 'package:crudapp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
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
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      scaffoldMessengerMsg = "Account Registered Sucessfully!";
                    } on FirebaseAuthException catch (e) {
                      scaffoldMessengerMsg = e.message!;
                    }
                  } else {
                    scaffoldMessengerMsg = "Email Password Required";
                  }
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(scaffoldMessengerMsg)),);
                },
                child: Text("Register", style: TextStyle(fontSize: 18)),
              ),
            ),

            SizedBox(height: 20),

            Text.rich(
              TextSpan(
                text: "Already have an account?",
                style: TextStyle(
                  color: Colors.white,
                ), 
                children: [
                  TextSpan(
                    text: " Login",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(builder: (context) => Login()),
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
