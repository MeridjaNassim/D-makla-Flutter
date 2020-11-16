import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_rlutter_ui/src/elements/CardsCarouselWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  List<Marker> allMarkers = [];
  RestaurantsList _restaurantsList;
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

//  @override
  void initState() {
    _restaurantsList = new RestaurantsList();
    _restaurantsList.restaurantsList.forEach((res) {
      getMarker(res).then((value) {
        setState(() {
          allMarkers.add(value);
        });
      });
    });
//    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Maps Explorer',
          style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
//        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: _kPosition,
            markers: Set.from(allMarkers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          CardsCarouselWidget()
        ],
      ),
    );
  }

//  Future<void> _goToTheLake() async {
//    final GoogleMapController controller = await _controller.future;
//    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  Future<Marker> getMarker(Restaurant res) async {
    final Uint8List markerIcon = await getBytesFromAsset('img/marker.png', 120);
    final Marker marker = Marker(
        markerId: MarkerId(res.id),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        onTap: () {
          print(res.name);
        },
        position: LatLng(res.lat, res.lon));

    return marker;
  }
}

/*Future<LocationData> _getCurrentLocation() async {
    LocationData currentLocation;

    var location = new Location();

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      currentLocation = await location.getLocation();
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      _kPosition = CameraPosition(
        target: LatLng(36.427963580664, 5.085749655962),
        zoom: 14.4746,
      );
      return currentLocation;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
        return null;
      }
      return null;
    }
  }*/
