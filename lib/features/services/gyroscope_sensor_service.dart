import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeSensorService {
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  final Function(bool) onTiltChanged; // Callback to toggle dark mode

  GyroscopeSensorService({required this.onTiltChanged});

  void startListening() {
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      _handleGyroscopeChange(event.x, event.y, event.z);
    });
  }

  void stopListening() {
    _gyroscopeSubscription?.cancel();
    _gyroscopeSubscription = null;
  }

  void _handleGyroscopeChange(
      double rotationX, double rotationY, double rotationZ) {
    // Detect tilt by checking rotation around X or Y axis (adjust thresholds as needed)
    const double tiltThreshold = 3.0; // Degrees/second, adjust for sensitivity
    bool isTilted =
        rotationX.abs() > tiltThreshold || rotationY.abs() > tiltThreshold;

    if (isTilted) {
      onTiltChanged(
          true); // Trigger dark mode toggle (HomeCubit will alternate)
    }
  }
}
