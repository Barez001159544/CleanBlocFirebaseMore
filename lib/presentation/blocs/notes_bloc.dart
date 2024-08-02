import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/core/connectivity.dart';
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
      if(await connectivityInfo.isConnected==false){
        emit(WriteNotesFailed("No Internet Connection"));
      }
      final response= await notesRepository.writeNote(event.title, event.note);
      response.fold(
          (l)=> emit(WriteNotesFailed("Error Writing Note")),
          (r)=> emit(WriteNotesSuccess())
      );
    });
    on<ReadNotes>((event, emit) async {
      emit(ReadNotesLoading());
      if (await connectivityInfo.isConnected == false) {
        emit(ReadNotesFailed("No Internet Connection"));
      }else{
      try {
        final stream = notesRepository.listenToNoteChanges(event.fromNewest);
        await for (var result in stream) {
          result.fold(
                (error) => emit(ReadNotesFailed("Error Reading Notes")),
                (snapshot) {
                  notesList.clear();
              for (var change in snapshot.docs) {
                  var note = NotesModel.fromJson(change);
                  notesList.add(note.toDomain());
              }
              emit(ReadNotesSuccess());
            },
          );
        }
      } catch (error) {
        emit(ReadNotesFailed("Error Reading Notes"));
      }
    }
      // await for (var snapshot in stream) {
      //   print(event.fromNewest);
      //   notesList.clear();
      //   snapshot.docs.forEach((change) {
      //     var data = change;
      //     if (data.data() != null && data.data() is Map<String, dynamic>) {
      //       var device = NotesModel.fromJson(data);
      //       notesList.add(device.toDomain());
      //     }
      //   });
      //   emit(ReadNotesSuccess());
      // }
    });
    on<UpdateNotes>((event, emit) async{
      if(await connectivityInfo.isConnected==false){
        emit(UpdateNotesFailed("No Internet Connection"));
      }

      final response = await notesRepository.updateNote(event.iD, event.title, event.note);
      if (response == null) {
        emit(UpdateNotesFailed("Error Updating Note"));
      } else {
        response.fold(
              (l) => emit(UpdateNotesFailed("Error Updating Note")),
              (r) => emit(UpdateNotesSuccess()),
        );
      }
    });
    on<DeleteNotes>((event, emit) async{
      emit(DeleteNotesLoading());
      if(await connectivityInfo.isConnected==false){
        emit(DeleteNotesFailed("No Internet Connection"));
      }
      final response = await notesRepository.deleteNote(event.iD);
      if (response == null) {
        emit(DeleteNotesFailed("Error Deleting Note"));
      } else {
        response.fold(
              (l) => emit(DeleteNotesFailed("Error Deleting Note")),
              (r) => emit(DeleteNotesSuccess()),
        );
      }
    });
  }
}

