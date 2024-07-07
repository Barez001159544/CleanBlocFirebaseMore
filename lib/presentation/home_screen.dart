import "package:crud/presentation/blocs/notes_bloc.dart";
import "package:crud/presentation/blocs/notes_events.dart";
import "package:crud/presentation/blocs/notes_state.dart";
import "package:crud/data/firestore_services.dart";
import "package:crud/domain/notes_repository.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

FirestoreServices firestoreServices = FirestoreServices();
NotesRepository notesRepository = NotesRepository(remote: firestoreServices);
final NotesBloc notesBloc= NotesBloc(notesRepository: notesRepository, );

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    notesBloc.add(ReadNotes());
    super.initState();
  }
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
                      notesBloc.add(WriteNotes(note: txtController.text));
                      BlocProvider.of<NotesBloc>(context).add(WriteNotes(note: txtController.text));
                    }else{
                      notesBloc.add(UpdateNotes(iD: docID, note: txtController.text));
                    }
                    txtController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text("Add"),
                ),
              ],
            ));
  }
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
        listener: (context, state) {
          // Handle side effects, if any
        },
        builder: (context, state) {
          if (state is ReadNotesInitial || state is ReadNotesLoading) {
            return const Center(child: Text("Notes LOADING"));
          }
          if (state is ReadNotesFailed) {
            return const Center(child: Text("Notes FAILED"));
          }
          return ListView.builder(
            itemCount: notesBloc.notesList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  notesBloc.notesList[index].note,
                  style: const TextStyle(color: Colors.black),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        openDialog(docID: notesBloc.notesList[index].id);
                      },
                      icon: const Icon(Icons.settings_rounded),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: () {
                        notesBloc.add(DeleteNotes(iD: notesBloc.notesList[index].id));
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
