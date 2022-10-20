import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TurbineGauge extends StatefulWidget {
  const TurbineGauge({Key? key}) : super(key: key);
  @override _TurbineGaugeState createState() => _TurbineGaugeState();
}

class _TurbineGaugeState extends State<TurbineGauge> with TickerProviderStateMixin  {

  late Timer _timer;
  int _speed = 1;

  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: _speed),
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

  void _setWindDBSpeed(val) {
    if (mounted) {
      setState(() {
        double s = double.parse(val);
        _speed = s.toInt();
        _speed = (_speed / 10).toInt();
        if (_speed < 0) {
          _speed = 1;
        } else if (_speed > 100) {
          _speed = 100;
        }
          _controller.duration = Duration(seconds: _speed);
          _controller.forward();
          _controller.repeat();
        });

      print(_speed);
    }
  }

  void _getWindFromDB(QuerySnapshot snapshot) {
    for (var doc in snapshot.docs) {
        if (mounted) {
          setState(() {
            _setWindDBSpeed(doc['rotorSpeed']);
          });
        }
    }
  }

  @override
  void initState() {
    _dB.listen((event) {_getWindFromDB(event);});
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 4,
            child: Stack(
            alignment: Alignment.center,
            textDirection: TextDirection.rtl,
            fit: StackFit.loose,
            children: [
              Positioned(
                top: 172,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xfffcfcff)),
                    color: Color(0xfffbfaf5),
                  ),
                  child:const SizedBox(height: 500 ,width:5),
                ),
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
                              needleLength: 0.5,
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
                              needleLength: 0.5,
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
                              needleLength: 0.5,
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
          ),
          Expanded(flex: 2, child: Container(),),
        ],
      ),
    );
  }
}