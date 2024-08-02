import 'package:crud/core/local_data.dart';
import 'package:crud/core/router_helper.dart';
import 'package:crud/core/theme_data.dart';
import 'package:crud/data/firestore_services.dart';
import 'package:crud/presentation/blocs/notes_bloc.dart';
import 'package:crud/firebase_options.dart';
import 'package:crud/presentation/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'domain/notes_repository.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await hiveHelper.init();

  runApp(const MyApp());
}

FirestoreServices firestoreServices = FirestoreServices();
NotesRepository notesRepository = NotesRepository(remote: firestoreServices);
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    final List allAsset = [
      "assets/images/add.png",
      "assets/images/alert.png",
      "assets/images/desorting.png",
      "assets/images/onboarding_background.png",
      "assets/images/plus.png",
      "assets/images/right-arrow.png",
      "assets/images/sorting.png",
    ];
      for(var asset in allAsset) {
        precacheImage(AssetImage(asset), context);
      }

    return MultiBlocProvider(
      providers: [
        BlocProvider<NotesBloc>(
          create: (context)=> NotesBloc(notesRepository: notesRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themeData,
        navigatorKey: RouterHelper.navigationKey,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

