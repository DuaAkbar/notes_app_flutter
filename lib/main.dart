import 'package:crudapp/firebase_options.dart';
import 'package:crudapp/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(crudapp());
}

class crudapp extends StatelessWidget {
  const crudapp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFFFA000),
          secondary: Color(0xFFFFCA28)
        )
      ),
      home: Login(),
    );
  }
}