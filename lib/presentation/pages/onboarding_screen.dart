import 'package:auto_size_text/auto_size_text.dart';
import 'package:crud/core/theme_data.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
   const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Center(
                  child: AutoSizeText(
                    textAlign: TextAlign.left,
                    "Hey, \nSome Texts above, \nThis texts cover, \nthe entire screen, \nexcept for a button below",
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
            Expanded(
              flex: 2,
              child: Container(
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          backgroundColor: WidgetStateProperty.all(themeData.scaffoldBackgroundColor),
                        ),
                          onPressed: (){},
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
            ),
          ],
        ),
      ),
    );
  }
}
