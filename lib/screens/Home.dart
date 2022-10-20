// @dart=2.9

import 'package:bwtk/widgets/Compass.dart';
import 'package:flutter/material.dart';

// Custom Widgets
import '../widgets/CenterIndicators.dart';
import '../widgets/TurbineGauge.dart';

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
      body:
          Row(children: [
            Expanded(flex: 1,
            child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Expanded(
                     flex: 1,
                     child: Compass(),
                   ),
                   const Expanded(
                     flex: 1,
                     child: TurbineGauge(),
                   )
                 ]
              )
            ),
            Expanded(flex: 1, child: CenterIndicators()),
          ],),

    );
  }
}