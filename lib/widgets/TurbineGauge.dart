import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TurbineGauge extends StatefulWidget {
  @override _TurbineGaugeState createState() => _TurbineGaugeState();
}

class _TurbineGaugeState extends State<TurbineGauge> {

  double _finPos = 0;

  late Timer _timer;

  final Stream _dB = FirebaseFirestore.instance.collection('kioskData')
      .orderBy('time', descending: true)
      .limit(1)
      .snapshots(includeMetadataChanges: true);

  void _updateFinPosition() {
    if (mounted) {
      setState(() {
        _finPos = (_finPos + 1) % 360;
      });
    }
  }

  void _setSpeed(Timer t1) {
    _timer = t1;
    _updateFinPosition();
  }

  void _setWindDBSpeed(val) {
    if (mounted) {
      setState(() {
        double s = double.parse(val);
        int speed = 100 - s.toInt();
        if (speed < 20) speed = 20;
        Timer.periodic(Duration(milliseconds: speed), (timer) { _setSpeed(timer);});
      });
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
    Timer.periodic(Duration(milliseconds: 200), (Timer t1) => _setSpeed(t1));
    _dB.listen((event) {_getWindFromDB(event);});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: SfRadialGauge(
            axes:<RadialAxis>[RadialAxis(
                showAxisLine: false,
                showLabels: false,
                showTicks: false,
                pointers: <GaugePointer>[
                  NeedlePointer(
                      value: _finPos,
                      lengthUnit: GaugeSizeUnit.factor,
                      needleLength: 0.8,
                      needleEndWidth:  3,
                      tailStyle: const TailStyle(length: 0.2, width: 1,
                        gradient:LinearGradient(
                            colors: <Color>[
                              Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                              Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                            stops: <double>[0, 0.5, 0.5, 1]),
                      ),
                      gradient: const LinearGradient(
                          colors: <Color>[
                            Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                            Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                          stops: <double>[0, 0.5, 0.5, 1]),
                      needleColor: const Color(0xFFFFFAF0),
                      knobStyle: const KnobStyle(
                          knobRadius: 0.03,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: Color(0xFFD1D9E1))),
                  NeedlePointer(
                      value: (_finPos + 90) % 360,
                      lengthUnit: GaugeSizeUnit.factor,
                      needleLength: 0.8,
                      needleEndWidth: 3,
                      tailStyle: const TailStyle(length: 0.2, width: 1,
                        gradient:LinearGradient(
                            colors: <Color>[
                              Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                              Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                            stops: <double>[0, 0.5, 0.5, 1]),
                      ),
                      gradient: const LinearGradient(
                          colors: <Color>[
                            Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                            Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                          stops: <double>[0, 0.5, 0.5, 1]),
                      needleColor: const Color(0xFFFFFAF0),
                      knobStyle: const KnobStyle(
                          knobRadius: 0.03,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: Color(0xFFD1D9E1))),
                  NeedlePointer(
                      value: (_finPos + 180) % 360,
                      lengthUnit: GaugeSizeUnit.factor,
                      needleLength: 0.8,
                      needleEndWidth:  3,
                      tailStyle: const TailStyle(length: 0.2, width: 1,
                        gradient:LinearGradient(
                            colors: <Color>[
                              Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                              Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                            stops: <double>[0, 0.5, 0.5, 1]),
                      ),
                      gradient: const LinearGradient(
                          colors: <Color>[
                            Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                            Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                          stops: <double>[0, 0.5, 0.5, 1]),
                      needleColor: const Color(0xFFFFFAF0),
                      knobStyle: const KnobStyle(
                          knobRadius: 0.03,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: Color(0xFFD1D9E1))),
                  NeedlePointer(
                      value: (_finPos + 270) % 360,
                      lengthUnit: GaugeSizeUnit.factor,
                      needleLength: 0.8,
                      needleEndWidth:  3,
                      tailStyle: const TailStyle(length: 0.2, width: 1,
                        gradient:LinearGradient(
                            colors: <Color>[
                              Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                              Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                            stops: <double>[0, 0.5, 0.5, 1]),
                      ),
                      gradient: const LinearGradient(
                          colors: <Color>[
                            Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                            Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                          stops: <double>[0, 0.5, 0.5, 1]),
                      needleColor: const Color(0xFFFFFAF0),
                      knobStyle: const KnobStyle(
                          knobRadius: 0.03,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: Color(0xFFD1D9E1))),
                  NeedlePointer(
                      value: (_finPos + 360) % 360,
                      lengthUnit: GaugeSizeUnit.factor,
                      needleLength: 0.8,
                      needleEndWidth:  3,
                      tailStyle: const TailStyle(length: 0.2, width: 1,
                        gradient:LinearGradient(
                            colors: <Color>[
                              Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                              Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                            stops: <double>[0, 0.5, 0.5, 1]),
                      ),
                      gradient: const LinearGradient(
                          colors: <Color>[
                            Color(0xFFFFFAF0), Color(0xFFFFFAF0),
                            Color(0xFFE1D9D1), Color(0xFFE1D9D1)],
                          stops: <double>[0, 0.5, 0.5, 1]),
                      needleColor: const Color(0xFFFFFAF0),
                      knobStyle: const KnobStyle(
                          knobRadius: 0.03,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: Color(0xFFD1D9E1))),
                ],
                interval: 30, showFirstLabel: false,
                startAngle: 270, endAngle: 270, minimum: 0, maximum: 360),
            ],

        ),
      ),
    );
  }
}