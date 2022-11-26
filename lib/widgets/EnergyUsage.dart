import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnergyUsage extends InheritedWidget {
  EnergyUsage({required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static Stream dB() {
    return FirebaseFirestore.instance.collection('kioskData')
      .orderBy('time', descending: true)
      .limit(1)
      .snapshots(includeMetadataChanges: true);
  }

  static EnergyUsage of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<EnergyUsage>()!;
  }

}
