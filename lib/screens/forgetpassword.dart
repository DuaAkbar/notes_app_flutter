import 'package:crudapp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => ForgetpasswordState();
}

class ForgetpasswordState extends State<Forgetpassword> {
  final TextEditingController emailcontroller = TextEditingController();

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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 60),
                ),
                onPressed: () async {
                  String email = emailcontroller.text;
                  String scaffoldMessengerMsg = "";
                  if (email.trim().isNotEmpty) {
                    await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: email,
                    );
                    scaffoldMessengerMsg =
                        "Password Reset Email has been sent!";
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (context) => Login()),
                    );
                  } else {
                    scaffoldMessengerMsg = "Please enter your email";
                  }

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(scaffoldMessengerMsg)));
                },
                child: Text("Send Email"),
              ),
            ),

            SizedBox(height: 20),

            Text.rich(
              TextSpan(
                text: "Already have an account?",
                style: TextStyle(
                  color: Colors.white,
                ), // Optional: to set base text color
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
