import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:segment_display/segment_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather/weather.dart';
import 'TurbineGauge.dart';

class CenterIndicators extends StatefulWidget {
  @override
  createState() => _CenterIndicatorsState();
}

class _CenterIndicatorsState extends State<CenterIndicators> {
  late WeatherFactory _wf;
  late Weather _w;
  final Stream _dB = FirebaseFirestore.instance.collection('kioskData')
      .orderBy('time', descending: true)
      .limit(1)
      .snapshots(includeMetadataChanges: true);
  double lcdSize = 3.0;
  double fontSize = 10.0;
  var fontColor = Colors.white;
  double rmsCurrentPhaseA = 0.0;
  double rmsCurrentPhaseB = 0.0;
  double rmsCurrentPhaseC = 0.0;
  double rmsLineVoltPhaseA = 0.0;
  double rmsLineVoltPhaseB = 0.0;
  double rmsLineVoltPhaseC = 0.0;
  double ambientTemp = 10.0;
  bool error = true;
  double gridFreq = 0.0;
  bool highAlarm = true;
  double inverterEnergyTotal = 0.0;
  double inverterReactivePower = 0.0;
  double inverterRealPower = 0.0;
  bool lowAlarm = true;
  double rotorSpeed = 0.0;
  String time = "";
  double turbineRuntime = 0.0;
  double windSpeedOneMinAvg = 0.0;
  double windSpeedOneSecAvg = 0.0;
  double windDirection = 0.0;
  String windStrDir = "";
  void _queryWeather() async {
    //_w = await _wf.currentWeatherByCityName("Boone");
    //windDirection = _w.windDegree!;
    //_setStringWindDirection();
    //print(windStrDir);
  }

  void _setStringWindDirection() {
    if (windDirection > 330 || windDirection <= 30) {
      windStrDir = "North";
    }
    else if (windDirection > 30 && windDirection <= 60) {
      windStrDir = "North-East";
    }
    else if (windDirection > 60 && windDirection <= 120) {
      windStrDir = "East";
    }
    else if (windDirection > 120 && windDirection <= 150) {
      windStrDir = "South-East";
    }
    else if (windDirection > 150 && windDirection <= 210) {
      windStrDir = "South";
    }
    else if (windDirection > 210 && windDirection <= 240) {
      windStrDir = "South-West";
    }
    else if (windDirection > 240 && windDirection <= 300) {
      windStrDir = "West";
    }
    else if (windDirection > 300 && windDirection <= 330) {
      windStrDir = "North-West";
    }
  }

  void _setRmsCurrentPhaseA(val) {
    if (mounted) {
      setState(() {
        rmsCurrentPhaseA = double.parse(val);
      });
    }
  }

  void _setRmsCurrentPhaseB(val) {
    if (mounted) {
      setState(() {
        rmsCurrentPhaseB = double.parse(val);
      });
    }
  }

  void _setRmsCurrentPhaseC(val) {
    if (mounted) {
      setState(() {
        rmsCurrentPhaseC = double.parse(val);
      });
    }
  }

  void _setRmsLineVoltPhaseA(val) {
    if (mounted) {
      setState(() {
        rmsLineVoltPhaseA = double.parse(val);
      });
    }
  }

  void _setRmsLineVoltPhaseB(val) {
    if (mounted) {
      setState(() {
        rmsLineVoltPhaseB = double.parse(val);
      });
    }
  }

  void _setRmsLineVoltPhaseC(val) {
    if (mounted) {
      setState(() {
        rmsLineVoltPhaseC = double.parse(val);
      });
    }
  }

  void _setAmbientTemp(val) {
    if (mounted) {
      setState(() {
        ambientTemp = double.parse(val);
      });
    }
  }

  void _setError(val) {
    if (mounted) {
      setState(() {
        error = val == '1';
      });
    }
  }

  void _setGridFreq(val) {
    if (mounted) {
      setState(() {
        gridFreq = double.parse(val);
      });
    }
  }

  void _setHighAlarm(val) {
    if (mounted) {
      setState(() {
        highAlarm = val == '1';
      });
    }
  }

  void _setInverterEnergyTotal(val) {
    if (mounted) {
      setState(() {
        inverterEnergyTotal = double.parse(val);
      });
    }
  }

  void _setInverterReactivePower(val) {
    if (mounted) {
      setState(() {
        inverterReactivePower = double.parse(val);
      });
    }
  }

  void _setInverterRealPower(val) {
    if (mounted) {
      setState(() {
        inverterRealPower = double.parse(val);
      });
    }
  }

  void _setLowAlarm(val) {
    if (mounted) {
      setState(() {
        lowAlarm = val == '1';
      });
    }
  }

  void _setRotorSpeed(val) {
    if (mounted) {
      setState(() {
        rotorSpeed = double.parse(val);
      });
    }
  }

  void _setTime(val) {
    if (mounted) {
      setState(() {
        time = val;
      });
    }
  }

  void _setTurbineRuntime(val) {
    if (mounted) {
      setState(() {
        turbineRuntime = double.parse(val);
      });
    }
  }

  void _setWindSpeedOneMinAvg(val) {
    if (mounted) {
      setState(() {
        windSpeedOneMinAvg = double.parse(val);
      });
    }
  }

  void _setWindSpeedOneSecAvg(val) {
    if (mounted) {
      setState(() {
        windSpeedOneSecAvg = double.parse(val);
      });
    }
  }

  void setMetrics(QuerySnapshot snapshot) async {
    for (var doc in snapshot.docs) {
      if (mounted) {
        setState(() {
          _setRmsCurrentPhaseA(doc['RMSLineCurrentPhaseA']);
          _setRmsCurrentPhaseB(doc['RMSLineCurrentPhaseB']);
          _setRmsCurrentPhaseC(doc['RMSLineCurrentPhaseC']);
          _setRmsLineVoltPhaseA(doc['RMSLineVoltagePhaseA_N']);
          _setRmsLineVoltPhaseB(doc['RMSLineVoltagePhaseB_N']);
          _setRmsLineVoltPhaseC(doc['RMSLineVoltagePhaseC_N']);
          _setAmbientTemp(doc['ambientTemp']);
          _setError(doc['error']);
          _setGridFreq(doc['gridFrequency']);
          _setHighAlarm(doc['highalarm']);
          _setInverterEnergyTotal(doc['inverterEnergyTotal']);
          _setInverterReactivePower(doc['inverterReactivePower']);
          _setInverterRealPower(doc['inverterRealPower']);
          _setLowAlarm(doc['lowalarm']);
          _setRotorSpeed(doc['rotorSpeed']);
          _setTime(doc['time']);
          _setTurbineRuntime(doc['turbineRuntime']);
          _setWindSpeedOneMinAvg(doc['windSpeedOneMinAvg']);
          _setWindSpeedOneSecAvg(doc['windSpeedOneSecAvg']);
        });
        //_queryWeather();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _dB.listen((event) {setMetrics(event);});
    //_wf = WeatherFactory("09db9f31b72a3defea4c187740b577db");
    //_queryWeather();
  }

  @override
  Widget build(BuildContext context) {
    return
          SingleChildScrollView(
            child: Column(children: [
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: rmsCurrentPhaseA.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("RMSCurrentPhaseA", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: rmsCurrentPhaseB.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("RMSCurrentPhaseB", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: rmsCurrentPhaseC.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("RMSCurrentPhaseC", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: rmsLineVoltPhaseA.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("RMSLineVoltPhaseA", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: rmsLineVoltPhaseB.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("RMSLineVoltPhaseB", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: rmsLineVoltPhaseC.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("RMSLineVoltPhaseC", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: ambientTemp.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("Ambient Temp", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: error.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("Error", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: gridFreq.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("Grid Frequency", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: highAlarm.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("High Alarm", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: inverterEnergyTotal.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("Inverter Energy Total", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: inverterReactivePower.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("Inverter Reactive Power", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: inverterRealPower.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("Inverter Real Power", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: lowAlarm.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("Low Alarm", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: rotorSpeed.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("Rotor Speed", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: turbineRuntime.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("Turbine Runtime", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: windSpeedOneMinAvg.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("Wind Speed (1 min avg.)", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  SizedBox(
                    //color: Colors.red,
                      child: SixteenSegmentDisplay(
                        value: windSpeedOneSecAvg.toString(),
                        size: lcdSize,
                        backgroundColor: Colors.transparent,
                        segmentStyle: RectSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: const Color(0x00000000).withOpacity(0.05)),
                      )),
                  Container(child: Text("Wind Speed (1 sec avg.)", style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
                  Container(child: Text(("Timestamp: $time" ), style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),)),
            ])
          );
  }
}