import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';
import 'package:segment_display/segment_display.dart';

class EnergyEquivalency extends StatefulWidget {
  @override
  createState() => _EnergyEquivalencyState();
}

class _EnergyEquivalencyState extends State<EnergyEquivalency> {

  final oCcy = NumberFormat("#,##0.00", "en_US");
  late double _rate;
  late double _inverterEnergyTotal;
  double lcdSize = 3.0;
  double fontSize = 13.0;
  var fontColor = Colors.white;
  String _valueGenerated = "";

  final Stream _dB = FirebaseFirestore.instance.collection('kioskData')
      .orderBy('time', descending: true)
      .limit(1)
      .snapshots(includeMetadataChanges: true);

  final queryParameters = {
    'version': '3',
    'format': 'json',
    'api_key': 'rJNcgIuAgMriodhsAQdKgrqksXkJKw2VIspVhUhM',
    'eia': '13482',
    'detail': 'full',
    'sector': 'Residential',
    'limit': '1',
  };

  Future<void> pollEnergyAPI() async {
    final uri = Uri.https('api.openei.org', '/utility_rates', queryParameters);
    final response = await http.get(uri);
    Map<String, dynamic> decodedResponse = jsonDecode(
        utf8.decode(response.bodyBytes));
    _rate = decodedResponse['items'][0]['energyratestructure'][0][0]['rate'];
  }

  void setInverterEnergyTotal(val) {
    if (mounted) {
      setState(() {
        _inverterEnergyTotal = double.parse(val);
        _valueGenerated = ('\$${oCcy.format(double.parse(sprintf("%.2f",[_inverterEnergyTotal*_rate])))}');
      });
    }
  }

  Future<void> setMetrics(QuerySnapshot snapshot) async {
    for (var doc in snapshot.docs) {
      if (mounted) {
        await pollEnergyAPI();
        setState(() {
          setInverterEnergyTotal(doc['inverterEnergyTotal']);
        });
      }
    }
  }

    @override
    void initState() {
      super.initState();
      _dB.listen((event) {
        setMetrics(event);
      });
    }

    @override
    void dispose() {
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Column(children: [
      Container(
        child: SixteenSegmentDisplay(
          characterCount: 11,
          value: _valueGenerated,
          size: lcdSize,
          backgroundColor: Colors.transparent,
          segmentStyle: RectSegmentStyle(
          enabledColor: Color(0xff009755),
          disabledColor: const Color(0x00000000).withOpacity(0.05)),
        ),
      ),
      Container(height: 10,),
      Container(child: Text("Estimated Cost Savings", style: TextStyle(decoration: TextDecoration.none,
      color: fontColor, fontSize: fontSize),)),
      ]);
    }
  }
