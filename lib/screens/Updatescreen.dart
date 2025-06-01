import 'package:crudapp/services/firebaseServices.dart';
import 'package:flutter/material.dart';

class Updatescreen extends StatefulWidget {
  final Map note;
  final String docId;
  const Updatescreen({super.key, required this.note, required this.docId});

  @override
  State<Updatescreen> createState() => _UpdatescreenState();
}

class _UpdatescreenState extends State<Updatescreen> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  @override
  void initState() {
    titlecontroller.text = widget.note["title"];
    descriptioncontroller.text = widget.note["description"];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await Firebaseservices().deleteNote(widget.docId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Note deleted successfully")),
              );
              Navigator.pop(context); // Optional: go back after deleting
            },
          ),
        ],
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

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
      ),

      floatingActionButton: FloatingActionButton(
        hoverColor: Theme.of(context).primaryColor,
        onPressed: () {
          final title = titlecontroller.text;
          final description = descriptioncontroller.text;
          if (title.trim().isNotEmpty && description.trim().isNotEmpty) {
            Map<String, String> note = {
              "title": title,
              "description": description,
              "created_at": widget.note["created_at"],
              "updated_at": DateTime.now().toString(),
            };
            Firebaseservices().updateNotesInDb(widget.docId, note);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Note Updated Successfully")),
            );
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Empty note cannot be Updated")),
            );
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
