// @dart=2.9
import 'package:flutter/material.dart';
import 'screens/Home.dart';
// Database
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Lock in landscape
import 'package:flutter/services.dart';

void main() {
  MyApp app = const MyApp();

  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


  void initState() {
  }

  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);  // to re-show bars
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return FutureBuilder(
      initialData: const Scaffold(
        backgroundColor: Color(0xff1B2430),
        body: Center(child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator())),
      ),
      // Initialize FlutterFire
      future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Center(child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator()));
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(
            title: 'Broyhill Wind Turbine',
            debugShowCheckedModeBanner: false,
            home: Home(),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Container(color: const Color(0xff1B2430), child: const Center(child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator())));
      },
    );
  }
}