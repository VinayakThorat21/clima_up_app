import 'package:geolocator/geolocator.dart';

class LocationData {
  late double _latitude;
  late double _longitude;

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    _latitude = position.latitude;
    _longitude = position.longitude;
  }

  double getLatitude() {
    return _latitude;
  }

  double getLongitude() {
    return _longitude;
  }
}
