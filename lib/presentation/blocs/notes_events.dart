abstract class NotesEvents{}

class ReadNotes extends NotesEvents{
  final bool fromNewest;
  ReadNotes({required this.fromNewest});
}

class WriteNotes extends NotesEvents{
  final String note;
  WriteNotes({required this.note});
}

class DeleteNotes extends NotesEvents{
  final String iD;
  DeleteNotes({required this.iD});
}

class UpdateNotes extends NotesEvents{
  final String iD;
  final String note;
  UpdateNotes({required this.iD, required this.note});
}