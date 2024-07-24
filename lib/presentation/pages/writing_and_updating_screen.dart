import 'package:crud/core/theme_data.dart';
import 'package:crud/presentation/blocs/notes_bloc.dart';
import 'package:crud/presentation/blocs/notes_events.dart';
import 'package:crud/presentation/blocs/notes_state.dart';
import 'package:crud/presentation/widgets/delAndUpButton.dart';
import 'package:crud/presentation/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool showPopup=false;
  String popupMessage= "Sure you want to delete?";
  Color closeButtonColor= Colors.grey;
  bool isConfirmShown= true;
  late void Function() onYes;

  @override
  void initState() {
    super.initState();
    noteTitleController = TextEditingController(text: widget.noteTitle);
    noteContentController = TextEditingController(text: widget.noteContent);
    onYes=(){};
  }


  void _startTimeout() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          showPopup = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: notesBloc,
      listener: (context, state){
        if(state is WriteNotesSuccess){
          Navigator.of(context).pop();
        }
        if(state is WriteNotesFailed){
          setState(() {
            showPopup=true;
            popupMessage= "Error updating note";
            closeButtonColor= Colors.red;
            onYes=(){};
            isConfirmShown= false;
          });
          _startTimeout();
        }
        if(state is UpdateNotesFailed){
          setState(() {
            showPopup=true;
            popupMessage= "Error updating note";
            closeButtonColor= Colors.red;
            onYes=(){};
            isConfirmShown= false;
          });
          _startTimeout();
        }
        if(state is DeleteNotesFailed){
          setState(() {
            showPopup=true;
            popupMessage= "Error updating note";
            closeButtonColor= Colors.red;
            onYes=(){};
            isConfirmShown= false;
          });
          _startTimeout();
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              leadingWidth: 100,
              surfaceTintColor: Colors.transparent,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: themeData.scaffoldBackgroundColor,
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 32,
                        width: 32,
                        "assets/images/right-arrow.png",
                      ),
                      const SizedBox(width: 10,),
                      const Text("BACK", style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
              ),
              actions: [
                if(widget.docID!=null)
                SizedBox(
                  width: 100,
                  child: DeleteAndUpdateButton(btnText: "DELETE", btnTextColor: Colors.red, onClick: (){
                    setState(() {
                      showPopup=true;
                      popupMessage= "Sure you want to delete?";
                      closeButtonColor= Colors.grey;
                      onYes=(){
                        notesBloc.add(DeleteNotes(iD: widget.docID!));
                      };
                      isConfirmShown= true;
                    });
                  }),
                ),
                if(widget.docID!=null)
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 100,
                  child: DeleteAndUpdateButton(btnText: "DONE", btnTextColor: Colors.green, onClick: (){
                    if(noteContentController.text.isNotEmpty){
                      if(widget.docID==null) {
                        notesBloc.add(WriteNotes(title: noteTitleController.text, note: noteContentController.text));
                      }else{
                        notesBloc.add(UpdateNotes(iD: widget.docID!, title: noteTitleController.text, note: noteContentController.text));
                      }
                    }else{
                      setState(() {
                        showPopup=true;
                        popupMessage= "Note content is empty!";
                        closeButtonColor= Colors.amber;
                        onYes=(){};
                        isConfirmShown= false;
                      });
                      _startTimeout();
                    }
                  }),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Text(widget.cuDate!=""?widget.cuDate:"Now", style: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: noteTitleController,
                    style: const TextStyle(fontSize: 45),
                    decoration: const InputDecoration(
                      hintText: "Title",
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: noteContentController,
                    style: const TextStyle(fontSize: 14),
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "Write note content here...",
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
          PopUpWidget(showPopup: showPopup, message: popupMessage, closeButtonColor: closeButtonColor, isConfirmShown: isConfirmShown, onYes: onYes,),
        ],
      ),
    );
  }
}
