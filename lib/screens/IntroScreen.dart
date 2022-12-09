import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'EmailLogin.dart';
import 'Home.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    return SplashScreen(
      navigateAfterSeconds: result != null ? const Home() : const EmailLogin(),
      seconds: 5,
      title: const Text(
        'REI Dashboard System',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.white70),
      ),
      image: Image.asset('images/rei.png', fit: BoxFit.scaleDown,),
      loadingText: const Text("Authenticating User Session",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.green)),
      backgroundColor: const Color(0xff1B2430),
      styleTextUnderTheLoader: const TextStyle(),
      photoSize: 300.0,
      loaderColor: Colors.green);
  }
}