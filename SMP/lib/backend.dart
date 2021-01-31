import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smp/firestore.dart';
import 'user_location.dart';
import 'package:provider/provider.dart';

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
            body: ManMan(),
          )),
    );
  }
}

class MapLocate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Center(child: Text('Lat:${userLocation.latitude}'));
  }
}

class ManMan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Scaffold(
      body:
          Database('', '${userLocation.latitude}', '${userLocation.longitude}'),
    );
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

// class Bui extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<UserLocation>(
//       create: (context) => LocationService().locationStream,
//       child: MaterialApp(
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//           ),
//           home: Scaffold(
//             body: MapLocate(),
//           )),
//     );
//   }
// }
