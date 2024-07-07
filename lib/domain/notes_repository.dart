import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/data/firestore_services.dart';
import 'package:dartz/dartz.dart';

abstract class INotesRepository{
  Stream<QuerySnapshot<Object?>> listenToNoteChanges();
  Future<Either<Exception, dynamic>> writeNote(String txt);
  Future<dynamic> updateNote(String ID, String newNote);
  Future<dynamic> deleteNote(String ID);
}

class NotesRepository implements INotesRepository{
  final FirestoreServices remote;
  NotesRepository({required this.remote});

  @override
  Stream<QuerySnapshot<Object?>> listenToNoteChanges() {
    final Stream<QuerySnapshot<Object?>> stream= remote.listenToChanges();
    return stream;
  }

  @override
  Future updateNote(String ID, String newNote) {
    return remote.updateNote(ID, newNote);
  }

  @override
  Future<Either<Exception, dynamic>> writeNote(String txt) {
    return remote.writeNote(txt);
  }

  @override
  Future deleteNote(String ID) {
    return remote.deleteNote(ID);
  }

}