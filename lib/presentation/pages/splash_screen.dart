import 'package:crud/core/local_data.dart';
import 'package:crud/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
bool? firstTime;
class _SplashScreenState extends State<SplashScreen> {
  void getFirstTime()async{
    firstTime = await hiveHelper.getValue(key: "firstTime");
  }
  @override
  void initState() {
    super.initState();
    hiveHelper.init();
    getFirstTime();
    print(firstTime);
    Future.delayed(const Duration(seconds: 3), (){
      if(mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return const HomeScreen();
      }));
      }
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
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                "assets/images/note_logo.svg",
            ),
            const SizedBox(height: 10,),
            const Text("Notefy", style: TextStyle(fontSize: 20),),
            const Spacer(),
            const Text("NOTE YOUR LIFE", style: TextStyle(fontSize: 16, color: Colors.grey),),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
