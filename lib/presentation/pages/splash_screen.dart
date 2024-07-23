import 'package:crud/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return HomeScreen();
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SvgPicture.asset(
              height: 100,
              width: 100,
              color: Colors.white,
                "assets/images/note_logo.svg",
            ),
            SizedBox(height: 10,),
            Text("Notefy", style: TextStyle(fontSize: 20),),
            Spacer(),
            SizedBox(
              height: 1,
              width: 100,
              child: LinearProgressIndicator(
                minHeight: 1,
                backgroundColor: Colors.grey,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
