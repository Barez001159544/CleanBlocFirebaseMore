import 'package:auto_size_text/auto_size_text.dart';
import 'package:crud/core/theme_data.dart';
import 'package:crud/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
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
            decoration: BoxDecoration(
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
                SizedBox(height: 48,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0,),
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
                SizedBox(height: 48,),
                Container(
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          backgroundColor: WidgetStateProperty.all(themeData.scaffoldBackgroundColor),
                          shape: WidgetStateProperty.all(LinearBorder.none),
                        ),
                        onPressed: (){
                          Navigator.of(context).pushReplacement(
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeIn,
                                child: HomeScreen(),
                              ),
                          );
                          },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(8, 4, 24, 8),
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            // border: Border(
                            //   bottom: BorderSide(
                            //     color: Colors.white,
                            //     width: 1,
                            //   ),
                            // ),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Continue to Notefy"),
                                SizedBox(width: 10,),
                                Icon(Icons.arrow_forward, size: 16,),
                              ],
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
