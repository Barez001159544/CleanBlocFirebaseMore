import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/domain/notes_entity.dart';

class NotesModel{
  final String id;
  final String note;
  final Timestamp timestamp;

  NotesModel({required this.id, required this.note, required this.timestamp});

  factory NotesModel.fromJson(DocumentSnapshot obj){
    return NotesModel(
      id: obj.id,
      note: (obj.data() as Map<String, dynamic>)["note"] as String,
      timestamp: (obj.data() as Map<String, dynamic>)["timestamp"] as Timestamp,
    );
  }

  NotesEntity toDomain() {
    return NotesEntity(
      id: id,
      note: note,
      timestamp: timestamp,
    );
  }
}