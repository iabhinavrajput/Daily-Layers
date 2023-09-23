import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/s.png',
              fit: BoxFit.cover,
              // width: width * .9,
              height: height * .5,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Text(
              "TOP HEADLINES",
              style: GoogleFonts.anton(
                  letterSpacing: .6,
                  color: Colors.grey.shade700,
                  fontSize: 25.0),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              "DEVELOPED BY ABHINAV",
              style: GoogleFonts.anton(
                  letterSpacing: .6,
                  color: Colors.red.shade700,
                  fontSize: 12.0),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            SpinKitChasingDots(
              color: Colors.green.shade500,
            ),
          ],
        ),
      ),
    );
  }
}
