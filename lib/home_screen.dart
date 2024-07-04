import "package:cloud_firestore/cloud_firestore.dart";
import "package:crud/blocs/notes_bloc.dart";
import "package:crud/blocs/notes_events.dart";
import "package:crud/blocs/notes_state.dart";
import "package:crud/firestore_services.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

FirestoreServices firestoreServices = FirestoreServices();

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtController = TextEditingController();
  void openDialog({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: txtController,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if(docID==null) {
                      BlocProvider.of<NotesBloc>(context).add(WriteNotes(note: txtController.text));
                      // firestoreServices.writeNote(txtController.text);
                    }else{
                      firestoreServices.updateNote(docID, txtController.text);
                    }
                    txtController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text("Add"),
                ),
              ],
            ));
  }
final NotesBloc notesBloc= NotesBloc(firestoreServices: firestoreServices);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openDialog,
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<NotesBloc, NotesState>(
        bloc: notesBloc,
        listener: (context, state){
          //
        },
        builder: (context, state){
          if(state is WriteNotesInitial || state is WriteNotesLoading){
            return const Center(child: Text("Notes LOADING"),);
          }
          if(state is WriteNotesFailed){
            return const Center(child: Text("Notes FAILED"));
          }
          print("=================${notesBloc.stream}");
          return StreamBuilder<QuerySnapshot>(
            stream: firestoreServices.readNotes(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
              if (snapshot.hasData) {
                List notesList = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: notesList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot = notesList[index];
                      String documentID = documentSnapshot.id;
                      Map<String, dynamic> data =
                      documentSnapshot.data() as Map<String, dynamic>;
                      String noteTxt = data['note'];
                      return ListTile(
                        title: Text(noteTxt),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: (){
                                openDialog(docID: documentID);
                              },
                              icon: Icon(Icons.settings_rounded),
                            ),
                            SizedBox(width: 5,),
                            IconButton(
                              onPressed: (){
                                firestoreServices.deleteNote(documentID);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return Text("No Notes...");
              }
            },
          );
        },
      ),
    );
  }
}
