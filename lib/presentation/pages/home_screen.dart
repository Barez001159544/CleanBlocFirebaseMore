import "package:crud/presentation/blocs/notes_bloc.dart";
import "package:crud/presentation/blocs/notes_events.dart";
import "package:crud/presentation/blocs/notes_state.dart";
import "package:crud/data/firestore_services.dart";
import "package:crud/domain/notes_repository.dart";
import "package:crud/presentation/pages/writing_and_updating_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

FirestoreServices firestoreServices = FirestoreServices();
NotesRepository notesRepository = NotesRepository(remote: firestoreServices);
final NotesBloc notesBloc= NotesBloc(notesRepository: notesRepository,);

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  late final TabController _tabController;
  String numOfNotes="";
  bool fromNewest=true;

  void toggleSortingOrder() {
    setState(() {
      fromNewest = !fromNewest;
      notesBloc.add(ReadNotes(fromNewest: fromNewest));
    });
  }

  @override
  void initState() {
    notesBloc.add(ReadNotes(fromNewest: fromNewest));
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
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
                      notesBloc.add(WriteNotes(title: "", note: txtController.text));
                      BlocProvider.of<NotesBloc>(context).add(WriteNotes(title: "", note: txtController.text));
                    }else{
                      notesBloc.add(UpdateNotes(iD: docID, title: "", note: txtController.text));
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
      floatingActionButton: FloatingActionButton(
        onPressed: openDialog,
        child: Icon(Icons.add),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text("Notes", style: TextStyle(color: Colors.grey, fontSize: 24),),
              floating: false,
              pinned: false,
              snap: false,
              forceElevated: innerBoxIsScrolled,
              actions: [
                GestureDetector(
                  onTap: ()=> toggleSortingOrder(),
                  child: Image.asset(
                    height: 32,
                    width: 32,
                    fromNewest?"assets/images/sorting.png":"assets/images/desorting.png",
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocListener<NotesBloc, NotesState>(
                        listener: (context, state){
    if(state is ReadNotesInitial || state is ReadNotesLoading){
      numOfNotes="-";
    }
    if(state is ReadNotesFailed){
      numOfNotes="0";
    }
    if(state is ReadNotesSuccess){
      numOfNotes= notesBloc.notesList.length.toString();
    }
                        },
                        bloc: notesBloc,
                          child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("All Notes", style: TextStyle(fontSize: 40),),
                  Text("$numOfNotes Notes", style: TextStyle(fontSize: 16),),
                  ],
                ),
                      ),
                      GestureDetector(
                        onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WritingAndUpdatingScreen())),
                        child: Container(
                          width: 70,
                          height: 70,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            border: Border.all(width: 1, color: Colors.grey.shade200),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Image.asset(
                            "assets/images/plus.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            BlocConsumer<NotesBloc, NotesState>(
              bloc: notesBloc,
              listener: (context, state) {
                // Handle side effects, if any
              },
              builder: (context, state) {
                if (state is ReadNotesInitial || state is ReadNotesLoading) {
                  return SizedBox(
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 1,
                          width: 100,
                          child: LinearProgressIndicator(
                            minHeight: 1,
                            backgroundColor: Colors.grey,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 100, // Set the width to match the LinearProgressIndicator
                          child: FittedBox(
                            fit: BoxFit.fill, // Ensure the text scales down to fit within the box
                            child: Text(
                              "Loading...",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (state is ReadNotesFailed) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          width: 50,
                          height: 50,
                          "assets/images/alert.png"),
                      SizedBox(height: 10,),
                      Text("An Error Occured"),
                    ],
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: notesBloc.notesList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return WritingAndUpdatingScreen(docID: notesBloc.notesList[index].id, noteTitle: notesBloc.notesList[index].title, noteContent: notesBloc.notesList[index].note, cuDate: "${DateTime.fromMillisecondsSinceEpoch(notesBloc.notesList[index].timestamp.millisecondsSinceEpoch).toString().split(" ")[0]} | ${DateTime.fromMillisecondsSinceEpoch(notesBloc.notesList[index].timestamp.millisecondsSinceEpoch).toString().split(" ")[1].split(".")[0]}",);
                        }));
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(child: Text((index+1).toString().padLeft(2, "0"))),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                  child: Text(notesBloc.notesList[index].title, style: TextStyle(fontSize: 45),),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.white, width: 1),
                                      ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text("${DateTime.fromMillisecondsSinceEpoch(notesBloc.notesList[index].timestamp.millisecondsSinceEpoch).toString().split(" ")[0]} | ${DateTime.fromMillisecondsSinceEpoch(notesBloc.notesList[index].timestamp.millisecondsSinceEpoch).toString().split(" ")[1].split(".")[0]}",),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Expanded(
                          //   child: Container(
                          //     height: 100,
                          //     decoration: BoxDecoration(
                          //       border: Border(
                          //         bottom: BorderSide(color: Colors.white, width: 1),
                          //       )
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
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
          ],
        ),
      )


    );
  }
}
