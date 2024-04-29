import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class GyroscopeWidget extends StatefulWidget {
  final Widget child;

  const GyroscopeWidget({super.key, required this.child});

  @override
  GyroscopeWidgetState createState() => GyroscopeWidgetState();
}

class GyroscopeWidgetState extends State<GyroscopeWidget>
    with SingleTickerProviderStateMixin {
  double _rotationX = 0.0;
  double _rotationY = 0.0;
  final _alpha = 0.1;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  @override
  void initState() {
    super.initState();
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _rotationX = _filteredValue(event.x * -0.1, _rotationX);
        _rotationY = _filteredValue(event.y * -0.1, _rotationY);
      });
    });
  }

  double _filteredValue(double newValue, double previousValue) {
    // Apply low-pass filter
    return previousValue + _alpha * (newValue - previousValue);
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // Perspective
        ..rotateX(_rotationX)
        ..rotateY(_rotationY),
      alignment: FractionalOffset.center,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }
}
