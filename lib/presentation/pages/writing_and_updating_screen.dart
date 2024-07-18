import 'package:crud/core/theme_data.dart';
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
    return Stack(
      children: [
        Scaffold(
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
              if(widget.docID!=null)
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
              if(widget.docID!=null)
              Container(
                height: 20,
                width: 1,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () {
                  if(noteContentController.text.isNotEmpty){
                    if(widget.docID==null) {
                      notesBloc.add(WriteNotes(title: noteTitleController.text, note: noteTitleController.text));
                      // notesBloc.add(WriteNotes(note: txtController.text));
                    }else{
                      notesBloc.add(UpdateNotes(iD: widget.docID!, title: noteTitleController.text, note: noteContentController.text));
                    }
                    // txtController.clear();
                    // Navigator.of(context).pop();
                  }
                  print("PRINTED OUTTTTTTTTTTTTT");
                  print(noteTitleController.text);
                  print(noteContentController.text);
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
                Text(widget.cuDate!=""?widget.cuDate:"Now", style: TextStyle(fontSize: 18),),
                SizedBox(height: 20,),
                TextField(
                  controller: noteTitleController,
                  style: TextStyle(fontSize: 45),
                  decoration: InputDecoration(
                    hintText: "Title",
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
                    hintText: "Content all over here...",
                    contentPadding: EdgeInsets.zero,
                    // fillColor: Colors.green,
                    // filled: true,
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: true,
          maintainState: false,
          child: SafeArea(
            child: Material(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        print("CLOSE");
                      },
                      child: Container(
                        color: Colors.grey,
                        width: 70,
                        height: 70,
                        child: Center(child: Icon(Icons.close,)),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text("Sure you want to delete?",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        print("YES");
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        color: Colors.white,
                        child: Center(
                          child: Text("Yes",
                            style: TextStyle(color: Colors.black, fontSize: 18),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
