import 'package:cloud_firestore/cloud_firestore.dart';

class NotesEntity{
  final String id;
  final String note;
  final String title;
  final Timestamp timestamp;

  NotesEntity({required this.id, required this.title, required this.note, required this.timestamp});
}