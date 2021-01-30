// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
// import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'user_location.dart';
import 'package:provider/provider.dart';
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
// }

class MapLocate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Center(child: Text('Lat:${userLocation.latitude}'));
  }
}

class LocationService {
  UserLocation _currentLocation;

  Location location = Location();
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    // Request permission to use location
    location.requestPermission().then((granted) {
      if (true) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
            ));
          }
        });
      }
    });
  }

  Stream<UserLocation> get locationStream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _currentLocation;
  }
}

class Bui extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      create: (context) => LocationService().locationStream,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            body: MapLocate(),
          )),
    );
  }
}

/*
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition());*/

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
