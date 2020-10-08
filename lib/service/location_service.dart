import 'package:geolocator/geolocator.dart';

class LocationService {
  double _latitude;
  double _longitude;

  double get latitude => _latitude;
  double get longitude => _longitude;

  LocationService();

  Future<void> getCurrentLocation() async {
    try {
      Position pos = await getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      _latitude = pos.latitude;
      _longitude = pos.longitude;
    } catch (e) {
      print(e);
    }
  }
}
