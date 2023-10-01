import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connect_x_app/constants/variables/shared.dart';
import 'package:connect_x_app/screens/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //const splashScreen({super.key});
  @override
  void initState() {
    super.initState();
    _navigatetohome(context);
  }

  _navigatetohome(context) async {
    await Future.delayed(const Duration(milliseconds: 6300), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: Container(
        width: double.infinity,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const Image(
                      image: AssetImage("images/icon.jpg"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                  child: Container(
                    child: Text(
                      "CONNECTX",
                      style: TextStyle(
                          color: darkColor,
                          fontFamily: regularFont,
                          fontWeight: FontWeight.w900,
                          fontSize: 40.0),
                    ),
                  ),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: regularFont,
                      color: darkColor,
                      letterSpacing: 9.0,
                      fontWeight: FontWeight.w700),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        'CONNECTING THE DOTS',
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
