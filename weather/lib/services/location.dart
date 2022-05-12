import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class Location {
  double? _longitude;
  double? get longitude => _longitude;

  double? _latitude;
  double? get latitude => _latitude;

  Future<void> getCurrentLocation() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      log(position.toString());
      _longitude = position.longitude;
      _latitude = position.latitude;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  String toString() => "Longitude: $_longitude\nLatitude: $_latitude";
}
