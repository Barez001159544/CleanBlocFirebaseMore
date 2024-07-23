import "package:crud/core/theme_data.dart";
import "package:crud/presentation/blocs/notes_bloc.dart";
import "package:crud/presentation/blocs/notes_events.dart";
import "package:crud/presentation/blocs/notes_state.dart";
import "package:crud/data/firestore_services.dart";
import "package:crud/domain/notes_repository.dart";
import "package:crud/presentation/pages/writing_and_updating_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:page_transition/page_transition.dart";

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
  bool fromNewest=true;
  String numOfNotes="-";

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text("Notefy", style: TextStyle(color: Colors.grey, fontSize: 24),),
              floating: false,
              pinned: false,
              snap: false,
              forceElevated: innerBoxIsScrolled,
              actions: [
                GestureDetector(
                  onTap: ()=> toggleSortingOrder(),
                  child: Container(
                    color: themeData.scaffoldBackgroundColor,
                    margin: EdgeInsets.only(right: 15),
                    child: Image.asset(
                      height: 32,
                      width: 32,
                      fromNewest?"assets/images/sorting.png":"assets/images/desorting.png",
                    ),
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(120),
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("All Notes", style: TextStyle(fontSize: 40)),
                          Text("${numOfNotes} Notes", style: TextStyle(fontSize: 16)),
                        ],
                      ),

                      GestureDetector(
                        onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WritingAndUpdatingScreen())),
                        child: Container(
                          width: 80,
                          height: 80,
                          padding: EdgeInsets.all(25),
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
                if(state is ReadNotesLoading){
                  setState(() {
                    numOfNotes= "-";
                  });
                }
                if(state is ReadNotesFailed){
                  setState(() {
                    numOfNotes= "0";
                  });
                }
                if(state is ReadNotesSuccess){
                  setState(() {
                    numOfNotes= notesBloc.notesList.length.toString();
                  });
                }
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
                          width: 100,
                          child: FittedBox(
                            fit: BoxFit.fill,
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
                        Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 400),
                              child: WritingAndUpdatingScreen(docID: notesBloc.notesList[index].id, noteTitle: notesBloc.notesList[index].title, noteContent: notesBloc.notesList[index].note, cuDate: "${DateTime.fromMillisecondsSinceEpoch(notesBloc.notesList[index].timestamp.millisecondsSinceEpoch).toString().split(" ")[0]} | ${DateTime.fromMillisecondsSinceEpoch(notesBloc.notesList[index].timestamp.millisecondsSinceEpoch).toString().split(" ")[1].split(".")[0]}",),
                          ),
                        );
                      },
                      child: Container(
                        color: themeData.scaffoldBackgroundColor,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Center(child: Text((fromNewest?index+1:int.parse(numOfNotes)-index).toString().padLeft(2, "0"))),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                    child: Text(notesBloc.notesList[index].title.isNotEmpty?notesBloc.notesList[index].title:"${DateTime.fromMillisecondsSinceEpoch(notesBloc.notesList[index].timestamp.millisecondsSinceEpoch).toString().split(" ")[0]}", style: TextStyle(fontSize: 45),),
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
                                    padding: EdgeInsets.only(bottom: 10),
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
                          ],
                        ),
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
