import 'package:crud/presentation/blocs/notes_bloc.dart';
import 'package:crud/presentation/blocs/notes_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/firestore_services.dart';
import '../../domain/notes_repository.dart';

class WritingAndUpdatingScreen extends StatefulWidget {
  WritingAndUpdatingScreen({
    super.key,
    this.docID,
    this.noteTitle="",
    this.noteContent="",
    this.cuDate="",
  });

  String? docID;
  String noteTitle;
  String noteContent;
  String cuDate;
  @override
  State<WritingAndUpdatingScreen> createState() => _WritingAndUpdatingScreenState();
}

class _WritingAndUpdatingScreenState extends State<WritingAndUpdatingScreen> {
  final NotesBloc notesBloc= NotesBloc(notesRepository: NotesRepository(remote: FirestoreServices()),);
  late TextEditingController noteTitleController;
  late TextEditingController noteContentController;

  @override
  void initState() {
    super.initState();
    noteTitleController = TextEditingController(text: widget.noteTitle);
    noteContentController = TextEditingController(text: widget.noteContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        // backgroundColor: Colors.blue,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            constraints: BoxConstraints(maxWidth: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  height: 32,
                  width: 32,
                  "assets/images/right-arrow.png",
                ),
                SizedBox(width: 5,),
                Text("BACK", style: TextStyle(fontSize: 18),),
              ],
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              height: kToolbarHeight,
              width: 100,
              child: Center(child: Text("DELETE", style: TextStyle(fontSize: 18, color: Colors.red),)),
            ),
          ),
          Container(
            height: 20,
            width: 1,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: () {
              print("PRINTED OUTTTTTTTTTTTTT");
              print(noteTitleController.text);
              print(noteContentController.text);
              if(widget.docID==null) {
                notesBloc.add(WriteNotes(title: noteTitleController.text, note: noteTitleController.text));
               // notesBloc.add(WriteNotes(note: txtController.text));
              }else{
                notesBloc.add(UpdateNotes(iD: widget.docID!, title: noteTitleController.text, note: noteContentController.text));
              }
              // txtController.clear();
              // Navigator.of(context).pop();
            },
            child: SizedBox(
              height: kToolbarHeight,
              width: 100,
              child: Center(child: Text("DONE", style: TextStyle(fontSize: 18, color: Colors.green),)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("7/5/24 | 6:59 PM", style: TextStyle(fontSize: 18),),
            SizedBox(height: 20,),
            TextField(
              controller: noteTitleController,
              style: TextStyle(fontSize: 45),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
              maxLines: 1,
            ),
            SizedBox(height: 20,),
            TextField(
              controller: noteContentController,
              style: TextStyle(fontSize: 14),
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                // fillColor: Colors.green,
                // filled: true,
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
