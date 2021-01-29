import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'dart:async';
// import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';

// import 'homepage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geoflutterfire/geoflutterfire.dart';
// import 'package:geolocator/geolocator.dart';

// Location location = new Location();

// locationData() async {
//   bool _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) {
//       return;
//     }
//   }

//   PermissionStatus _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       return;
//     }
//   }

//   location.onLocationChanged.listen((LocationData currentLocation) {
//     // Use current location
//   });
// }

class MapLocate extends StatefulWidget {
  @override
  _MapLocateState createState() => _MapLocateState();
}

class _MapLocateState extends State<MapLocate> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(90, -90);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Share My Pad'),
          backgroundColor: Colors.pink[300],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
