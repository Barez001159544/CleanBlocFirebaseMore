import 'package:crud/core/local_data.dart';
import 'package:crud/core/theme_data.dart';
import 'package:crud/data/firestore_services.dart';
import 'package:crud/presentation/blocs/notes_bloc.dart';
import 'package:crud/firebase_options.dart';
import 'package:crud/presentation/pages/onboarding_screen.dart';
import 'package:crud/presentation/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'domain/notes_repository.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await hiveHelper.init();
  runApp(MyApp());
}

FirestoreServices firestoreServices = FirestoreServices();
NotesRepository notesRepository = NotesRepository(remote: firestoreServices);
class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotesBloc>(
          create: (context)=> NotesBloc(notesRepository: notesRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

