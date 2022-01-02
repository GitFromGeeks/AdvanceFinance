import 'package:af/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context,
            PageTransition(
                child: Home(),
                type: PageTransitionType.topToBottom,
                duration: Duration(seconds: 4)))
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => Home())

        //     )

        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('af.gif'),
          fit: BoxFit.contain,
        ),
      ),
      child: Text(""),
    );
  }
}
