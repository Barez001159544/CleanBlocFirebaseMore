import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/blocs/notes_events.dart';
import 'package:crud/blocs/notes_state.dart';
import 'package:crud/firestore_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../notes_model.dart';

class NotesBloc extends Bloc<NotesEvents, NotesState>{
  final FirestoreServices firestoreServices;

  NotesBloc({required this.firestoreServices}):super(WriteNotesInitial()){
    on<WriteNotes>((event, emit) async{
      emit(WriteNotesLoading());
      final response= await firestoreServices.writeNote(event.note);
      response.fold(
          (l)=> emit(WriteNotesFailed()),
          (r)=> emit(WriteNotesSuccess())
      );
    });
    on<ReadNotes>((event, emit) async{
      emit(ReadNotesLoading());
      final Stream<QuerySnapshot<Object?>> stream =firestoreServices.readNotes();
      stream.listen((event){
        for(var change in event.docChanges){
          final note= NotesModel.fromJson(change.doc.data() as Map<String, dynamic>);
          emit(ReadNotesSuccess());
        }
      });
    });
    on<UpdateNotes>((event, emit) async{
      final response = await firestoreServices.updateNote(event.iD, event.note);
      response.fold(
          (l)=> emit(DeleteNotesFailed()),
          (r)=> emit(DeleteNotesSuccess()),
      );
    });
    on<DeleteNotes>((event, emit) async{
      final response = await firestoreServices.deleteNote(event.iD);
      response.fold(
          (l)=> emit(DeleteNotesFailed()),
          (r)=> emit(DeleteNotesSuccess()),
      );
    });
  }
}