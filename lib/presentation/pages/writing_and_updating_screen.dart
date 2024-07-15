import 'package:flutter/material.dart';

class WritingAndUpdatingScreen extends StatefulWidget {
  const WritingAndUpdatingScreen({super.key});

  @override
  State<WritingAndUpdatingScreen> createState() => _WritingAndUpdatingScreenState();
}

class _WritingAndUpdatingScreenState extends State<WritingAndUpdatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            backgroundColor: Colors.blue,
            leadingWidth: 100,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                constraints: BoxConstraints(maxWidth: 100),
                color: Colors.red,
                child: Row(
                  children: [
                    Image.asset(
                      height: 32,
                      width: 32,
                      "assets/images/right-arrow.png",
                    ),
                    SizedBox(width: 5,),
                    Text("BACK", style: TextStyle(fontSize: 18),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Text("CENTER"),
      ),
    );
  }
}
