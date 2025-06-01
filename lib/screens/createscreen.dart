import 'package:crudapp/screens/homepage.dart';
import 'package:crudapp/services/firebaseServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Createscreen extends StatefulWidget {
  const Createscreen({super.key});

  @override
  State<Createscreen> createState() => _CreatescreenState();
}

class _CreatescreenState extends State<Createscreen> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
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

      body: Column(
        children: [
          TextField(
            controller: titlecontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFF404A58)),
              ),
              hintText: "Title",
            ),
            maxLines: 2,
            minLines: 1,
          ),

          SizedBox(height: 20),

          TextField(
            controller: descriptioncontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFF404A58)),
              ),
              hintText: "Description",
            ),
            maxLines: 20,
            minLines: 8,
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final title = titlecontroller.text;
          final description = descriptioncontroller.text;
          if (title.trim().isNotEmpty && description.trim().isNotEmpty) {
            final Firebaseservices firebaseservices = Firebaseservices();

            final Map<String, String> note = {
              "title": title,
              "description": description,
              "created_at": DateTime.now().toString(),
            };

            print(note);
            firebaseservices.addNotesToDb(note);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Note Created Successfully")),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Empty note cannot be Created")),
            );
          }

          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => Homepage()),
          );
        },
        child: Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
