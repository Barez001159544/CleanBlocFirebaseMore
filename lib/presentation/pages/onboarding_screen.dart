import 'package:auto_size_text/auto_size_text.dart';
import 'package:crud/core/local_data.dart';
import 'package:crud/core/theme_data.dart';
import 'package:crud/presentation/pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';

class OnboardingScreen extends StatefulWidget {
   const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/onboarding_background.png"),
                fit: BoxFit.fill,
              ),
              color: Colors.blue,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 48,),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                    child: Center(
                      child: AutoSizeText(
                        textAlign: TextAlign.left,
                        "Welcome!\nHere You Can Write, Read, Update and Delete Notes Anytime You Like.\nLet's Hop in.",
                        maxFontSize: 240,
                        minFontSize: 24,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                        backgroundColor: WidgetStateProperty.all(themeData.scaffoldBackgroundColor),
                        shape: WidgetStateProperty.all(LinearBorder.none),
                      ),
                      onPressed: () async{
                        final userCredential = await signInWithGoogle();
                        if (userCredential != null)
                          print(userCredential);
                        // hiveHelper.createOrUpdate("firstTime", true);
                        // Navigator.of(context).pushReplacement(
                        //     PageTransition(
                        //       type: PageTransitionType.rightToLeft,
                        //       duration: const Duration(milliseconds: 400),
                        //       curve: Curves.easeIn,
                        //       child: const HomeScreen(),
                        //     ),
                        // );
                        },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(8, 4, 24, 8),
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Continue w/"),
                              SizedBox(width: 5,),
                              Text("Google", style: TextStyle(fontFamily: 'Google',),),
                              SizedBox(width: 10,),
                              Icon(Icons.arrow_forward, size: 16,),
                            ],
                          ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on Exception catch (e) {
    // TODO
    print('exception->$e');
  }
}