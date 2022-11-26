// @dart=2.9

import 'package:bwtk/widgets/Compass.dart';
import 'package:bwtk/widgets/PictoMatcher.dart';
import 'package:flutter/material.dart';

// Custom Widgets
import '../widgets/PowerChart.dart';
import '../widgets/TurbineGauge.dart';


class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
  static int rightIndex = 0;
}

class HomeState extends State<Home> {
  double fontSize = 13.0;
  var fontColor = Colors.white;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xff1B2430),
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
                      Expanded(child: Container(), flex: 1,),
                      const Expanded(
                          flex: 14,
                          child:
                           SizedBox(
                            height: 390,
                            width: 500,
                            child:
                            TurbineGauge()
                          )
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(child: Container(), flex: 1),
                      //Container(child: TurnSignal()),
                      Container(
                        height: 450,
                        width: 500,
                        child: IndexedStack(
                          index: Home.rightIndex,
                          children: [
                            PictoMatcher(),
                            Column(
                              children: [
                                SizedBox(
                                  height: 390,
                                  width: 500,
                                  child: PowerChart(),
                                ),
                                Container(height: 10),
                                Text("7 Day Power Output (kW)", style: TextStyle(decoration: TextDecoration.none,
                                    color: fontColor, fontSize: fontSize),),
                              ],
                            ),

                            Column(
                              children: [
                                SizedBox(
                                  height: 390,
                                  width: 500,
                                  child: PowerChart(),
                                ),
                                Container(height: 10),
                                Text("7 Day Power Output (kW)", style: TextStyle(decoration: TextDecoration.none,
                                    color: fontColor, fontSize: fontSize),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(children: [
                        const VerticalDivider(width: 15),
                        if (Home.rightIndex > 0)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                --Home.rightIndex;
                              });
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xffedd711),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xffffffff).withOpacity(0),
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(18),
                            ),
                          ),
                        if (Home.rightIndex == 0) const VerticalDivider(width: 65),
                        const VerticalDivider(width: 150),
                        if (Home.rightIndex < 2)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                ++Home.rightIndex;
                              });
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffedd711),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff03050a).withOpacity(0),
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(18),
                            ),
                          ),
                        if (Home.rightIndex == 2) const VerticalDivider(width: 65),
                      ]),
                      Expanded(child: Container(), flex: 1,)
                    ],

                  ),
                ]
            )
        ),

      ],),

    );
  }
}