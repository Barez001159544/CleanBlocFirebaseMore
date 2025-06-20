import 'package:animate_text/animate_text.dart';
import 'package:crud/core/local_data.dart';
import 'package:crud/core/router_helper.dart';
import 'package:crud/presentation/pages/home_screen.dart';
import 'package:crud/presentation/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  bool? firstTime = hiveHelper.getValue(key: "firstTime");

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), (){
      if(mounted) {
        routerHelper.goto(screen: firstTime == null
            ? const OnboardingScreen()
            : const HomeScreen(), replace: true);
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
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
              child: SvgPicture.asset(
                height: 100,
                width: 100,
                colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  "assets/images/note_logo.svg",
              ),
            ),
            const SizedBox(height: 10,),
            const AnimateText("Evar Stationary", style: TextStyle(fontSize: 20), type: AnimateTextType.topLeftToBottomRight, isRepeat: false,),
            const Spacer(),
            const Text("EVAR WORLD OF STATIONARY", style: TextStyle(fontSize: 16, color: Colors.grey),),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
