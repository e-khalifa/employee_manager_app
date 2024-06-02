import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:employee_info/pages/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1400,
      splash: 'assets/images/em.png',
      nextScreen: const HomePage(),
      splashTransition: SplashTransition.rotationTransition,
    );
  }
}
