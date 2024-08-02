abstract class NotesState{}

///Write Notes

class WriteNotesInitial extends NotesState{}

class WriteNotesLoading extends NotesState{}

class WriteNotesFailed extends NotesState{
  final String message;
  WriteNotesFailed(this.message);
}

class WriteNotesSuccess extends NotesState{}

///Read Notes

class ReadNotesInitial extends NotesState{}

class ReadNotesLoading extends NotesState{}

class ReadNotesFailed extends NotesState{
  final String message;
  ReadNotesFailed(this.message);
}

class ReadNotesSuccess extends NotesState{}

///Update Notes

class UpdateNotesInitial extends NotesState{}

class UpdateNotesLoading extends NotesState{}

class UpdateNotesFailed extends NotesState{
  final String message;
  UpdateNotesFailed(this.message);
}

class UpdateNotesSuccess extends NotesState{}

///Delete Notes

class DeleteNotesInitial extends NotesState{}

class DeleteNotesLoading extends NotesState{}

class DeleteNotesFailed extends NotesState{
  final String message;
  DeleteNotesFailed(this.message);
}

class DeleteNotesSuccess extends NotesState{}