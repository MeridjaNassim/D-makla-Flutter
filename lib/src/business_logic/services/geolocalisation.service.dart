
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';



abstract class GeoLocalisationService {

  Future<GeoLocalisationPosition> getCurrentPosition();
}

class GeoLocalisationPosition extends Equatable{
  final double latitude;
  final double longitude;

  GeoLocalisationPosition(this.latitude, this.longitude);

  @override
  // TODO: implement props
  List<Object> get props => [latitude,longitude];
}

class GeoLocalisationImplGeolocator extends GeoLocalisationService {
  final LocationAccuracy accuracy;

  GeoLocalisationImplGeolocator({this.accuracy = LocationAccuracy.best});

  @override
  Future<GeoLocalisationPosition> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: this.accuracy);
    return GeoLocalisationPosition(position.latitude,position.longitude);
  }

}