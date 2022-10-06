// @dart=2.9
import 'package:flutter/material.dart';

// Custom Widgets
import '../widgets/CenterIndicators.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: CenterIndicators(),
    );
  }
}