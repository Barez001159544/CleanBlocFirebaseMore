import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

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

  Stream<QuerySnapshot<Object?>> listenToChanges(bool fromNewest) {
    print(fromNewest);
    return notes.orderBy("timestamp", descending: fromNewest).snapshots();
  }

  Future<dynamic> updateNote(String ID, String newNote) async{
    return notes.doc(ID).update({
        "note": newNote,
        "timestamp": Timestamp.now(),
      });
  }

  Future<dynamic> deleteNote(String ID) async {
      return notes.doc(ID).delete();
  }

}


