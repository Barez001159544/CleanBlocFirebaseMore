import 'package:cloud_firestore/cloud_firestore.dart';
class FirestoreServices{

  final CollectionReference notes= FirebaseFirestore.instance.collection("notes");

  Future<dynamic> writeNote(String txt) async{
    return notes.add({
      "note": txt,
      "timestamp": Timestamp.now()
    });
  }

  Stream<QuerySnapshot<Object?>> readNotes(){
    final notesStream= notes.orderBy("timestamp", descending: true).snapshots();
    return notesStream;
  }

  Future<dynamic> updateNote(String ID, String newNote) async{
    return notes.doc(ID).update({
      "note": newNote,
      "timestamp": Timestamp.now(),
    });
  }

  Future<dynamic> deleteNote(String ID){
    return notes.doc(ID).delete();
  }

}


