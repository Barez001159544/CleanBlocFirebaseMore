import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/blocs/notes_events.dart';
import 'package:crud/blocs/notes_state.dart';
import 'package:crud/firestore_services.dart';
import 'package:crud/notes_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../notes_model.dart';
import '../notes_repository.dart';


class NotesBloc extends Bloc<NotesEvents, NotesState>{
  final FirestoreServices firestoreServices;
  List<NotesEntity> notesList=[];

  INotesRepository notesRepository;

  NotesBloc({required this.firestoreServices, required this.notesRepository}):super(WriteNotesInitial()){
    on<WriteNotes>((event, emit) async{
      emit(WriteNotesLoading());
      final response= await firestoreServices.writeNote(event.note);
      response.fold(
          (l)=> emit(WriteNotesFailed()),
          (r)=> emit(WriteNotesSuccess())
      );
    });
    on<ReadNotes>((event, emit) async{
      emit(NotesLoading());
      final Stream<QuerySnapshot<Object?>> stream = await notesRepository.listenToNoteChanges();
      await for (var snapshot in stream) {
        notesList.clear();
        snapshot.docs.forEach((change) {
          var data = change;
          if (data.data() != null && data.data() is Map<String, dynamic>) {
            var device = NotesModel.fromJson(data);
            notesList.add(device.toDomain());
          }
        });
        emit(NotesSuccess());
      }

    });
    on<UpdateNotes>((event, emit) async{
      final response = await firestoreServices.updateNote(event.iD, event.note);
      if (response == null) {
        emit(UpdateNotesFailed());
      } else {
        response.fold(
              (l) => emit(UpdateNotesFailed()),
              (r) => emit(UpdateNotesSuccess()),
        );
      }
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

