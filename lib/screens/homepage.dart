import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudapp/screens/Updatescreen.dart';
import 'package:crudapp/screens/createscreen.dart';
import 'package:crudapp/screens/login.dart';
import 'package:crudapp/services/firebaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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

        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(builder: (context) => Login()),
              );
            },
            icon: Icon(Icons.logout), // This is the fix!
          ),
        ],
      ),

      body: StreamBuilder(
        stream: Firebaseservices().GetNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData == true) {
            List data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = data[index];
                String docId = doc.id;
                Map<String, dynamic> note = doc.data() as Map<String, dynamic>;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder:
                            (context) => Updatescreen(docId: docId, note: note),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFF404A58),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.all(8),

                    child: Column(
                      children: [
                        Text(
                          "Title",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),

                        Text(
                          "Description",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No Data Found"));
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => Createscreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
