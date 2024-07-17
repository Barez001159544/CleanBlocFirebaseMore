import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/presentation/blocs/notes_events.dart';
import 'package:crud/presentation/blocs/notes_state.dart';
import 'package:crud/domain/notes_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud/data/notes_model.dart';
import 'package:crud/domain/notes_repository.dart';


class NotesBloc extends Bloc<NotesEvents, NotesState>{
  List<NotesEntity> notesList=[];
  INotesRepository notesRepository;

  NotesBloc({required this.notesRepository}):super(WriteNotesInitial()){
    on<WriteNotes>((event, emit) async{
      emit(WriteNotesLoading());
      final response= await notesRepository.writeNote(event.title, event.note);
      response.fold(
          (l)=> emit(WriteNotesFailed()),
          (r)=> emit(WriteNotesSuccess())
      );
    });
    on<ReadNotes>((event, emit) async{
      emit(ReadNotesLoading());
      final Stream<QuerySnapshot<Object?>> stream = await notesRepository.listenToNoteChanges(event.fromNewest);
      await for (var snapshot in stream) {
        notesList.clear();
        snapshot.docs.forEach((change) {
          var data = change;
          if (data.data() != null && data.data() is Map<String, dynamic>) {
            var device = NotesModel.fromJson(data);
            notesList.add(device.toDomain());
          }
        });
        emit(ReadNotesSuccess());
      }
    });
    on<UpdateNotes>((event, emit) async{
      final response = await notesRepository.updateNote(event.iD, event.title, event.note);
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
      final response = await notesRepository.deleteNote(event.iD);
      if (response == null) {
        emit(DeleteNotesFailed());
      } else {
        response.fold(
              (l) => emit(DeleteNotesFailed()),
              (r) => emit(DeleteNotesSuccess()),
        );
      }
    });
  }
}

