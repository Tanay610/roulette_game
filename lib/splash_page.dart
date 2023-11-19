import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ruolette_game/spinn.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return SpinningWheelScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 115, 179),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/icons8-fortune-wheel-68.png"),
            SizedBox(
              height: 8,
            ),
            Text(
              "Roulette",
              style: TextStyle(
                  color: Colors.blue[100],
                  fontSize: 40,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

// const Color.fromARGB(255, 9, 50, 83),