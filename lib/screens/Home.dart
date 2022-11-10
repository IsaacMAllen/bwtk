// @dart=2.9

import 'package:bwtk/widgets/Compass.dart';
import 'package:flutter/material.dart';

// Custom Widgets
import '../widgets/PowerChart.dart';
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
                  const SizedBox(
                      width: 300,
                      height: 450,
                      child: Compass()
                  ),
                  Column(
                    children:[
                      const Expanded(
                          flex: 12,
                          child:
                           SizedBox(
                            height: 590,
                            width: 300,
                            child:
                            TurbineGauge()
                          )
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                          height: 590,
                          width: 500,
                          child: PowerChart(),
                      ),
                    ],
                  )

                ]
            )
        ),

      ],),

    );
  }
}