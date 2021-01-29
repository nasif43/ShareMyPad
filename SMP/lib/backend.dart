import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
// import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';

// import 'homepage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geoflutterfire/geoflutterfire.dart';
// import 'package:geolocator/geolocator.dart';

Location location = new Location();

locationData() async {
  bool _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  PermissionStatus _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }
  location.onLocationChanged.listen((LocationData currentLocation) {
    // Use current location
  });
}

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(snippet: 'Address'));
    setState(() {
      markers[markerId] = _marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        onTap: (tapped) {
          getMarkers(tapped.latitude, tapped.longitude);
        },
        mapType: MapType.hybrid,
        compassEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(target: LatLng(-90, 90)),
        markers: Set<Marker>.of(markers.values),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
/*
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition());*/
}

// void getCurrentLocation () async{
//   Position currentPosition = await GeolocatorPlatform.instance.getCurrentPosition();
//   }
// @override
// void initState(){
//   super.initState();
//   getCurrentLocation();
// }

// //on tapped
// final coordinated
// getMarkers(tapped.latitude, tapped.longitude);
// await FirebaseFirestore.instance.collection('location').add{
//   'latitude': tapped.latitude,
//   'longitude': tapped.longitude,
//   'Address': tapped
// }

// Location location = new Location();

// Firestore firestore = Firestore.instance;
// Geoflutterfire geo = Geoflutterfire();

// locationData() async {
//   var pos = await location.getLocation();
//   var locationdata = LatLng(pos.latitude, pos.latitude);
// }
