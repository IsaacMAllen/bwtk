import 'dart:async';

import 'package:bwtk/widgets/EnergyEquivalency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:segment_display/segment_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'EnergyUsage.dart';


class TurbineGauge extends StatefulWidget {
  const TurbineGauge({Key? key}) : super(key: key);
  @override _TurbineGaugeState createState() => _TurbineGaugeState();
}

class _TurbineGaugeState extends State<TurbineGauge> with TickerProviderStateMixin  {

  late Timer _timer;
  int _speed = 1;
  double lcdSize = 3.0;
  double fontSize = 13.0;
  var fontColor = Colors.white;
  double _realtimePower = 0.0;

  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: _speed),
    vsync: this,
  )..repeat(reverse: false);

  // Create an animation with value of type "double"
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  final Stream _dB = FirebaseFirestore.instance.collection('kioskData')
      .orderBy('time', descending: true)
      .limit(1)
      .snapshots(includeMetadataChanges: true);

  void _setRealPower(val) {
    if (mounted) {
      setState(() {
        _realtimePower = double.parse(val);
      });
    }
  }

  void _setWindDBSpeed(val) {
    if (mounted) {
      setState(() {
        double s = double.parse(val);
        _speed = s.toInt();
        _speed =  5000 - _speed;
        if (_speed == 5000) {
          _speed = 0;
          _controller.stop();
        }
        else if (_speed > 4990){
          _speed = 10000;
          _controller.duration = Duration(milliseconds: _speed);
          _controller.forward();
          _controller.repeat();
        }
        else if (_speed > 4980){
          _speed = 7000;
          _controller.duration = Duration(milliseconds: _speed);
          _controller.forward();
          _controller.repeat();
        }
        else if (_speed > 4970){
          _speed = 5000;
          _controller.duration = Duration(milliseconds: _speed);
          _controller.forward();
          _controller.repeat();
        }
        else if (_speed > 4960){
          _speed = 2000;
          _controller.duration = Duration(milliseconds: _speed);
          _controller.forward();
          _controller.repeat();
        }
        else {
          _speed = 1000;
          _controller.duration = Duration(milliseconds: _speed);
          _controller.forward();
          _controller.repeat();
        }
        });
    }
  }

  void _parseDB(QuerySnapshot snapshot) {
    for (var doc in snapshot.docs) {
        if (mounted) {
          setState(() {
            _setWindDBSpeed(doc['rotorSpeed']);
            _setRealPower(doc['inverterRealPower']);
          });
        }
    }
  }

  @override
  void initState() {
    EnergyUsage.dB().listen((event) {_parseDB(event);});
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(flex: 1, child: Container()),
          Stack(
            alignment: Alignment.center,
            textDirection: TextDirection.rtl,
            fit: StackFit.loose,
            children: [
              Positioned(
                top: 172,
                child: SizedBox(
                  child:
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xfffcfcff)),
                        color: Color(0xfffbfaf5),
                      ),
                      child:const SizedBox(height: 500 ,width:5),
                    ),
                  height: 500,
                  width: 5,
                )
              ),
              Positioned(
                child: RotationTransition(
                  turns: _animation,
                  child: SfRadialGauge(
                    axes:<RadialAxis>[RadialAxis(
                        showAxisLine: false,
                        showLabels: false,
                        showTicks: false,
                        pointers: const <GaugePointer>[
                          NeedlePointer(
                              value: 0,
                              lengthUnit: GaugeSizeUnit.factor,
                              needleLength: 0.4,
                              needleEndWidth:  3,
                              tailStyle: TailStyle(length: 0, width: 1,
                                gradient:LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                                      Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                                    stops: <double>[0, 0.5, 0.5, 1]),
                              ),
                              gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                                    Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                                  stops: <double>[0, 0.5, 0.5, 1]),
                              needleColor: Color(0xFFFFFAF0),
                              knobStyle: KnobStyle(
                                  knobRadius: 0.03,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  color: Color(0xFFD1D9E1))),
                          NeedlePointer(
                              value: 120,
                              lengthUnit: GaugeSizeUnit.factor,
                              needleLength: 0.4,
                              needleEndWidth: 3,
                              tailStyle: TailStyle(length: 0, width: 1,
                                gradient:LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                                      Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                                    stops: <double>[0, 0.5, 0.5, 1]),
                              ),
                              gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                                    Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                                  stops: <double>[0, 0.5, 0.5, 1]),
                              needleColor: Color(0xFFFFFAF0),
                              knobStyle: KnobStyle(
                                  knobRadius: 0.03,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  color: Color(0xFFD1D9E1))),
                          NeedlePointer(
                              value: 240,
                              lengthUnit: GaugeSizeUnit.factor,
                              needleLength: 0.4,
                              needleEndWidth:  3,
                              tailStyle: TailStyle(length: 0, width: 1,
                                gradient:LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                                      Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                                    stops: <double>[0, 0.5, 0.5, 1]),
                              ),
                              gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                                    Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                                  stops: <double>[0, 0.5, 0.5, 1]),
                              needleColor: Color(0xFFFFFAF0),
                              knobStyle: KnobStyle(
                                  knobRadius: 0.03,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  color: Color(0xFFD1D9E1))),

                        ],
                        interval: 30, showFirstLabel: false,
                        startAngle: 270, endAngle: 270, minimum: 0, maximum: 360),
                    ],
                  ),
                ),
              ),


            ],
        ),
          Expanded(flex: 2, child: Container(
            child:
              Column(
                children: [
                  Container(height: 10),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: _realtimePower.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(height: 10),
                  Container(child: Text("Realtime Power Output (kW)", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  Container(height: 10),
                  EnergyEquivalency(),
                ],
              )
          ),
          ),
        ],
    );
  }
}