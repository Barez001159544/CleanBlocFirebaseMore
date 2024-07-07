import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/firestore_services.dart';
import 'package:dartz/dartz.dart';

abstract class INotesRepository{
  Stream<QuerySnapshot<Object?>> listenToNoteChanges();
}

class NotesRepository implements INotesRepository{
  final FirestoreServices remote;
  NotesRepository({required this.remote});

  @override
  Stream<QuerySnapshot<Object?>> listenToNoteChanges() {
    final Stream<QuerySnapshot<Object?>> stream= remote.listenToChanges();
    return stream;
  }

}