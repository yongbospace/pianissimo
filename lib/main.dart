import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pianissimo/screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pianissimo',
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Montserrat',
      ),
      home: const SplashScreen(),
    ),
  );
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(milliseconds: 1000),
        () => Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (context, animation, secondAnimation) =>
                    const HomeScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                })));

    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Pianissimo",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  "assets/images/splash.jpeg",
                  fit: BoxFit.contain,
                  width: 240,
                  height: 240,
                ),
              ],
            ),
          ),
        ));
  }
}
