import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
class FirestoreServices{

  final CollectionReference notes= FirebaseFirestore.instance.collection("notes");

  Future<Either<Exception, dynamic>> writeNote(String txt) async{
    try{
      return right(notes.add({
        "note": txt,
        "timestamp": Timestamp.now()
      }));
    }catch(e){
      print(e);
      return left(Exception(e.toString()));
    }
  }

  Stream<QuerySnapshot<Object?>> readNotes(){
    final notesStream= notes.orderBy("timestamp", descending: true).snapshots();
    return notesStream;
  }

  Stream<QuerySnapshot<Object?>> listenToChanges() {
    return notes.snapshots();
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


