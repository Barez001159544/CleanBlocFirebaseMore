import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/data/firestore_services.dart';
import 'package:dartz/dartz.dart';

abstract class INotesRepository{
  Stream<QuerySnapshot<Object?>> listenToNoteChanges(bool fromNewest);
  Future<Either<Exception, dynamic>> writeNote(String title, String txt);
  Future<Either<Exception, dynamic>> updateNote(String ID, String newTitle, String newNote);
  Future<Either<Exception, dynamic>> deleteNote(String ID);
}

class NotesRepository implements INotesRepository{
  final FirestoreServices remote;
  NotesRepository({required this.remote});

  @override
  Stream<QuerySnapshot<Object?>> listenToNoteChanges(bool fromNewest) {
    final Stream<QuerySnapshot<Object?>> stream= remote.listenToChanges(fromNewest);
    return stream;
  }

  @override
  Future<Either<Exception, dynamic>> updateNote(String ID, String newTitle, String newNote) async {
    try {
      final result = await remote.updateNote(ID, newTitle, newNote);
      return right(result);
    } catch (e) {
      return left(Exception(e.toString()));
    }
  }


  @override
  Future<Either<Exception, dynamic>> writeNote(String title, String txt) async {
    try {
      final result = await remote.writeNote(title, txt);
      return right(result);
    } catch (e) {
      return left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, dynamic>> deleteNote(String ID) async {
    try {
      final result = await remote.deleteNote(ID);
      return right(result);
    } catch (e) {
      return left(Exception(e.toString()));
    }
  }


}