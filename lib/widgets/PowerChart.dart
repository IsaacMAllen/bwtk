import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PowerChart extends StatefulWidget {
  @override
  createState() => _PowerChartState();
}

class _PowerChartState extends State<PowerChart> {

  List<String> _weekSpots = [];
  List<FlSpot> _flWeekSpots = [];

  final Stream _weekly = FirebaseFirestore.instance.collection('kioskData')
      .orderBy('time', descending: true)
      .limit(2016)
      //.where('time', isLessThan: Timestamp.fromDate(DateTime.now()), isGreaterThan: Timestamp.fromDate(
      //DateTime.now().subtract(const Duration(days: 7))))
      .snapshots(includeMetadataChanges: true);



  void _setWeeklySpots(QuerySnapshot snapshot) {
    int i = 0;
    if (mounted) {
      setState(() {
      for (var doc in snapshot.docs) {
        if (i % 8 == 0) {
          _weekSpots.add((doc['inverterRealPower']));
        }
        i++;
        if (_weekSpots.length > 252) {
          _weekSpots = _weekSpots.skip(1).toList();
        }
    }
        _flWeekSpots =
        _weekSpots.reversed.toList().asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), double.parse(e.value));
        }).toList();
      });
    }
  }

  @override
  void initState() {
    _weekly.listen((event) {
      _setWeeklySpots(event);
    });
  }

  @override
  Widget build(BuildContext context) {

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 160,
        titlesData:
          FlTitlesData(
            show: true,
            leftTitles: AxisTitles(),
            topTitles: AxisTitles(),
            bottomTitles: AxisTitles(),
          ),
        borderData:
        FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: Color(0xff4e4965), width: 4),
              left: BorderSide(color: Color(0xff4e4965), width: 4),
              right: BorderSide(color: Color(0xff4e4965), width: 4),
              top: BorderSide(color: Color(0xff4e4965), width: 4),
            )
        ),
        lineBarsData:
          [
            LineChartBarData(
            isCurved: true,
            isStrokeJoinRound: true,
            curveSmoothness: 0.75,
            preventCurveOverShooting: true,
            color: const Color(0xff4af699),
            barWidth: 0.5,
            isStrokeCapRound: false,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
            spots: _flWeekSpots,
          )
        ]
        // read about it in the LineChartData section
      ),

    );
  }
}