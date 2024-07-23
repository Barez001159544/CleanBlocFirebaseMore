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
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return const HomeScreen();
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
            const Spacer(),
            SvgPicture.asset(
              height: 100,
              width: 100,
              color: Colors.white,
                "assets/images/note_logo.svg",
            ),
            const SizedBox(height: 10,),
            const Text("Notefy", style: TextStyle(fontSize: 20),),
            const Spacer(),
            const SizedBox(
              height: 1,
              width: 100,
              child: LinearProgressIndicator(
                minHeight: 1,
                backgroundColor: Colors.grey,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
