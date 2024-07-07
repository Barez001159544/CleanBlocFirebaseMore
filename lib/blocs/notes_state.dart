abstract class NotesState{}

class NotesInitial extends NotesState{}

class NotesLoading extends NotesState{}

class NotesFailed extends NotesState{}

class NotesSuccess extends NotesState{}

///Write Notes

class WriteNotesInitial extends NotesState{}

class WriteNotesLoading extends NotesState{}

class WriteNotesFailed extends NotesState{}

class WriteNotesSuccess extends NotesState{}

///Read Notes

class ReadNotesInitial extends NotesState{}

class ReadNotesLoading extends NotesState{}

class ReadNotesFailed extends NotesState{}

class ReadNotesSuccess extends NotesState{}

///Update Notes

class UpdateNotesInitial extends NotesState{}

class UpdateNotesLoading extends NotesState{}

class UpdateNotesFailed extends NotesState{}

class UpdateNotesSuccess extends NotesState{}

///Delete Notes

class DeleteNotesInitial extends NotesState{}

class DeleteNotesLoading extends NotesState{}

class DeleteNotesFailed extends NotesState{}

class DeleteNotesSuccess extends NotesState{}