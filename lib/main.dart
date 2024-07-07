import 'package:crud/blocs/notes_bloc.dart';
import 'package:crud/firebase_options.dart';
import 'package:crud/firestore_services.dart';
import 'package:crud/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notes_repository.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

FirestoreServices firestoreServices = FirestoreServices();
class MyApp extends StatelessWidget {
  MyApp({super.key});
  NotesRepository notesRepository = NotesRepository(remote: firestoreServices);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotesBloc>(
          create: (context)=> NotesBloc(firestoreServices: firestoreServices, notesRepository: notesRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

