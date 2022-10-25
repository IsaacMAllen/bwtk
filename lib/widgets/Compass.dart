/// Flutter package imports
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:segment_display/segment_display.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather/weather.dart';

/// Renders the gauge direction compass sample using annotation
class Compass extends StatefulWidget {
  const Compass({Key? key}) : super(key: key);

  /// Creates the gauge direction compass sample using annotation

  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  late WeatherFactory _wf;
  late Weather _w;
  double lcdSize = 3.0;
  double fontSize = 13.0;
  var fontColor = Colors.white;
  double _windDirection = 0.0;
  double _speedOneMin = 0.0;

  final Stream _dB = FirebaseFirestore.instance.collection('kioskData')
      .orderBy('time', descending: true)
      .limit(1)
      .snapshots(includeMetadataChanges: true);

  void _queryWeather() async {
    _w = await _wf.currentWeatherByCityName("Boone");
    if (mounted) {
      setState(() {
        _windDirection = _w.windDegree!;
      });
    }
  }

  void _setSpeed(QuerySnapshot snapshot) {
    for (var doc in snapshot.docs) {
      if (mounted) {
        setState(() {
          _speedOneMin = double.parse(doc['windSpeedOneMinAvg']);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _wf = WeatherFactory("09db9f31b72a3defea4c187740b577db");
    _queryWeather();
    Timer.periodic(const Duration(minutes: 1), (event) => {_queryWeather()});
    _dB.listen((event) {_setSpeed(event);});
  }

  @override
  Widget build(BuildContext context) {
    return _buildRadialCompass();
  }

  /// Returns the direction compass gauge using annotation support
  Column _buildRadialCompass() {
    return Column(
      children: [
        Expanded(
          flex: 10,
            child: Column(
          children: [
            SfRadialGauge(
                title: GaugeTitle(text: "Wind Direction", textStyle: TextStyle(decoration: TextDecoration.none,
    color: fontColor, fontSize: fontSize)),
                  axes: <RadialAxis>[
                    RadialAxis(
                        showAxisLine: false,
                        ticksPosition: ElementsPosition.outside,
                        labelsPosition: ElementsPosition.outside,
                        startAngle: 320,
                        endAngle: 320,
                        minorTicksPerInterval: 10,
                        maximum: 360,
                        interval: 30,
                        labelOffset: 20,
                        majorTickStyle: const MajorTickStyle(
                            length: 0.16, lengthUnit: GaugeSizeUnit.factor),
                        minorTickStyle: const MinorTickStyle(
                            length: 0.16, lengthUnit: GaugeSizeUnit.factor, thickness: 1),
                        axisLabelStyle: const GaugeTextStyle(),
                        pointers: <GaugePointer>[
                          MarkerPointer(value: _windDirection, markerType: MarkerType.triangle),
                          const NeedlePointer(
                              value: 310,
                              needleLength: 0.5,
                              needleColor: Color(0xFFC4C4C4),
                              needleEndWidth: 1,
                              knobStyle: KnobStyle(knobRadius: 0),
                              tailStyle: TailStyle(
                                  color: Color(0xFFC4C4C4), width: 1, length: 0.5)),
                          const NeedlePointer(
                            value: 221,
                            needleLength: 0.5,
                            needleColor: Color(0xFFC4C4C4),
                            needleEndWidth: 1,
                            knobStyle: KnobStyle(knobRadius: 0),
                          ),
                          const NeedlePointer(
                            value: 40,
                            needleLength: 0.5,
                            needleColor: Color(0xFFC4C4C4),
                            needleEndWidth: 1,
                            knobStyle: KnobStyle(knobRadius: 0),
                          )
                        ],
                        annotations: const <GaugeAnnotation>[
                          GaugeAnnotation(
                            angle: 230,
                            positionFactor: 0.38,
                            widget: Text('W',
                                style: TextStyle(
                                    fontFamily: 'Times',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                          GaugeAnnotation(
                            angle: 310,
                            positionFactor: 0.38,
                            widget: Text('N',
                                style: TextStyle(
                                    fontFamily: 'Times',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                          GaugeAnnotation(
                            angle: 129,
                            positionFactor: 0.38,
                            widget: Text('S',
                                style: TextStyle(
                                    fontFamily: 'Times',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                          GaugeAnnotation(
                            angle: 50,
                            positionFactor: 0.38,
                            widget: Text('E',
                                style: TextStyle(
                                    fontFamily: 'Times',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          )
                        ])
                  ],
              ),
            SizedBox(
              //color: Colors.red,
                child: SixteenSegmentDisplay(
                  value: _speedOneMin.toString(),
                  size: lcdSize,
                  backgroundColor: Colors.transparent,
                  segmentStyle: RectSegmentStyle(
                      enabledColor: Colors.green,
                      disabledColor: const Color(0x00000000).withOpacity(0.05)),
                )),
            Container(height: 10),
            Container(child: Text("Wind Speed (1 min. Avg)", style: TextStyle(decoration: TextDecoration.none,
                color: fontColor, fontSize: fontSize),)),
          ],
        )
      )


      ],
    );
  }
}