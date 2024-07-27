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
      body: Column(
        children: [
          Expanded(
            child: Text(
              "Hey\nSome Texts above\nThis texts cover\nthe entire screen\nexcept for a button below",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width*0.17,
                height: 1.1
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: (){},
                    child: Text("Continue to Notefy"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
