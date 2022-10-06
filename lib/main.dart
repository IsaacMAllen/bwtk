// @dart=2.9
import 'package:flutter/material.dart';
import 'screens/Home.dart';
// Database
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Lock in landscape
import 'package:flutter/services.dart';

void main() {
  MyApp app = MyApp();

  runApp(app);
}

class MyApp extends StatelessWidget {

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
      // Initialize FlutterFire
      future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator()));
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Broyhill Wind Turbine',
            debugShowCheckedModeBanner: false,
            home: Scaffold(body: Home(), backgroundColor: Colors.black,),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator()));
      },
    );
  }
}