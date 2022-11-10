import 'package:flutter/cupertino.dart';

class EnergyUsage extends InheritedWidget {
  final double realtimePower;
  @override
  EnergyUsage({required this.realtimePower, required Widget child}) : super(child: child);
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
