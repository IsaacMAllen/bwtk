/// Flutter package imports
import 'dart:async';

import 'package:flutter/material.dart';

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
  double _windDirection = 0.0;


  void _queryWeather() async {
    _w = await _wf.currentWeatherByCityName("Boone");
    if (mounted) {
      setState(() {
        _windDirection = _w.windDegree!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _wf = WeatherFactory("09db9f31b72a3defea4c187740b577db");
    _queryWeather();
    Timer.periodic(const Duration(minutes: 5), (event) => {_queryWeather()});
  }

  @override
  Widget build(BuildContext context) {
    return _buildRadialCompass();
  }

  /// Returns the direction compass gauge using annotation support
  SfRadialGauge _buildRadialCompass() {
    return SfRadialGauge(
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
    );
  }
}