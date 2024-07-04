import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel{
  final String note;
  final Timestamp timestamp;

  NotesModel({required this.note, required this.timestamp});

  factory NotesModel.fromJson(Map<String, dynamic> map){
    return NotesModel(
      note: map["note"] as String,
      timestamp: map["timestamp"] as Timestamp,
    );
  }
}