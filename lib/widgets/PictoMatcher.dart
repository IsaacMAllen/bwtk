import 'package:bwtk/widgets/EnergyUsage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PictoMatcher extends StatefulWidget {
  @override
  createState() => _PictoMatcherState();
}

class _PictoMatcherState extends State<PictoMatcher> {
  double _realtimePower = 0.0;
  double fontSize = 19.0;
  var fontColor = Colors.white;
  Text _title = const Text("");

  void _setRealPower(val) {
    if (mounted) {
      setState(() {
        _realtimePower = double.parse(val);
        if (_realtimePower > 0) {
          _title = Text("Currently Powering the Equivalent of about", style: TextStyle(decoration: TextDecoration.none,
              color: fontColor, fontSize: fontSize + 3),);
        }
        else {
          _title = Text("Currently Consuming the Equivalent of about", style: TextStyle(decoration: TextDecoration.none,
              color: fontColor, fontSize: fontSize + 3),);
        }
      });
    }
  }

  void _parseDB(QuerySnapshot snapshot) {
    for (var doc in snapshot.docs) {
      if (mounted) {
        setState(() {
          _setRealPower(doc['inverterRealPower']);
        });
      }
    }
  }

  @override
  void initState() {
    EnergyUsage.dB().listen((event) {
      _parseDB(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_realtimePower >= 20) {
        return Column(
          children: [
            Expanded(child: Container(), flex:4,),
            _title,
            SizedBox(
              height: 350,
              width: 500,
              child: Column(
                children: [
                  Expanded(child: Container(), flex: 1,),
                  Container(
                      height: 250,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: ExactAssetImage('images/house.png'))
                      )),
                  Container(height: 10),
                  Text(
                    (_realtimePower / 1.2).round().toString() +
                        " residential homes",
                    style: TextStyle(decoration: TextDecoration.none,
                        color: fontColor, fontSize: fontSize),),
                ],
              ),
            ),
            Expanded(child: Container(), flex:1,),
          ],
        );
    }
    else if (_realtimePower >= 10) {
        if ((_realtimePower * 1000 / 80).round() > 1) {
          return Column(
            children: [
              Expanded(child: Container(), flex:4,),
              _title,
              SizedBox(
                height: 350,
                width: 500,
                child: Column(
                  children: [
                    Expanded(child: Container(), flex: 1,),
                    Container(
                        height: 300,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: ExactAssetImage('images/light.png'))
                        )),
                    Container(height: 10),
                    Text(
                      (_realtimePower * 1000 / 80).round().toString() +
                          " LED street lights",
                      style: TextStyle(decoration: TextDecoration.none,
                          color: fontColor, fontSize: fontSize),),
                  ],
                ),
              ),
              Expanded(child: Container(), flex:1,),
            ],
          );
        }
        else {
          return Column(
            children: [
              Expanded(child: Container(), flex:4,),
              _title,
              SizedBox(
                height: 350,
                width: 500,
                child: Column(
                  children: [
                    Expanded(child: Container(), flex: 1,),
                    Container(
                        height: 300,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: ExactAssetImage('images/light.png'))
                        )),
                    Container(height: 10),
                    Text(
                      (_realtimePower * 1000 / 80).round().toString() +
                          " LED street light",
                      style: TextStyle(decoration: TextDecoration.none,
                          color: fontColor, fontSize: fontSize),),
                  ],
                ),
              ),
              Expanded(child: Container(), flex:1,),
            ],
          );
        }
    }
    if ((_realtimePower * 1000 / 80).round() > 1) {
      return Column(
        children: [
          Expanded(child: Container(), flex:4,),
          _title,
          SizedBox(
            height: 350,
            width: 500,
            child: Column(
              children: [
                Expanded(child: Container(), flex: 1,),
                Container(
                    height: 300,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage('images/tv.png'))
                    )),
                Container(height: 10),
                Text(
                  (_realtimePower * 1000 / 80).round().toString() +
                      " LED TVs",
                  style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),),
              ],
            ),
          ),
          Expanded(child: Container(), flex:1,),
        ],
      );
    }
    else if ((_realtimePower * 1000 / 80).round() > 0) {
      return Column(
        children: [
          Expanded(child: Container(), flex:4,),
          _title,
          SizedBox(
            height: 350,
            width: 500,
            child: Column(
              children: [
                Expanded(child: Container(), flex: 1,),
                Container(
                    height: 300,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage('images/tv.png'))
                    )),
                Container(height: 10),
                Text(
                  (_realtimePower * 1000 / 80).round().toString() +
                      " LED TV",
                  style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),),
              ],
            ),
          ),
          Expanded(child: Container(), flex:1,),
        ],
      );
    }
    else if ((_realtimePower * -1000 / 30).round() > 1) {
      return Column(
        children: [
          Expanded(child: Container(), flex:4,),
          _title,
          SizedBox(
            height: 350,
            width: 500,
            child: Column(
              children: [
                Container(
                    height: 318,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage('images/bulb.png'))
                    )
                ),
                Text((_realtimePower * -1000 / 30).round().toString() +
                    " Incandescent Microwave Light Bulbs",
                  style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),
                ),
              ],
            ),
          ),
          Expanded(child: Container(), flex:1,),
        ],
      );
    }
    else {
      return Column(
        children: [
          Expanded(child: Container(), flex:4,),
          _title,
          SizedBox(
            height: 350,
            width: 500,
            child: Column(
              children: [
                Container(
                    height: 318,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage('images/bulb.png'))
                    )
                ),
                Text("1 Incandescent Microwave Light Bulb",
                  style: TextStyle(decoration: TextDecoration.none,
                      color: fontColor, fontSize: fontSize),
                ),
              ],
            ),
          ),
          Expanded(child: Container(), flex:1,),
        ],
      );
    }
  }
}