import 'package:cloud_firestore/cloud_firestore.dart';

class Firebaseservices {
  final CollectionReference notesCollection = FirebaseFirestore.instance
      .collection("notes");

  //add notes
  Future<void> addNotesToDb(Map<String, String> notes) {
    return notesCollection.add(notes);
  }

  //get notes
  Stream<QuerySnapshot> GetNotesStream() {
    final notescreen =
        notesCollection.orderBy("created_at", descending: true).snapshots();
    return notescreen;
  }

  //update notes
  Future<void> updateNotesInDb(String docId, Map<String, String> note) {
    return notesCollection.doc(docId).update(note);
  }

  //delete notes
  Future<void> deleteNote(String docId,) {
    return notesCollection.doc(docId).delete();
  }
}
