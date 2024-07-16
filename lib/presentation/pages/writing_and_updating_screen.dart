import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WritingAndUpdatingScreen extends StatefulWidget {
  const WritingAndUpdatingScreen({super.key});

  @override
  State<WritingAndUpdatingScreen> createState() => _WritingAndUpdatingScreenState();
}

class _WritingAndUpdatingScreenState extends State<WritingAndUpdatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        // backgroundColor: Colors.blue,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            constraints: BoxConstraints(maxWidth: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              height: kToolbarHeight,
              width: 100,
              child: Center(child: Text("DELETE", style: TextStyle(fontSize: 18, color: Colors.red),)),
            ),
          ),
          Container(
            height: 20,
            width: 1,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              height: kToolbarHeight,
              width: 100,
              child: Center(child: Text("DONE", style: TextStyle(fontSize: 18, color: Colors.green),)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("7/5/24 | 6:59 PM", style: TextStyle(fontSize: 18),),
            SizedBox(height: 20,),
            TextField(
              controller: TextEditingController(text: "Personal Notes jfoa oafj"),
              style: TextStyle(fontSize: 45),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
              maxLines: 1,
            ),
            SizedBox(height: 20,),
            TextField(
              controller: TextEditingController(text: "Personal Notes Reloaded 1 of 1071 libraries in 1,130ms Personal Notes Reloaded 1 of 1071 libraries in 1,130ms Personal Notes Reloaded 1 of 1071 libraries in 1,130ms Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms). Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms). Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms). Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms). Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms). Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms). Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms). Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms). Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms). Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms). Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms). Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms). Personal Notes Reloaded 1 of 1071 libraries in 1,130ms (compile: 24 ms, reload: 411 ms, reassemble: 430 ms)."),
              style: TextStyle(fontSize: 14),
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                // fillColor: Colors.green,
                // filled: true,
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
