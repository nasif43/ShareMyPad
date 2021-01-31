import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final Firestore _store = Firestore.instance;

class Database extends StatelessWidget {
  final String fullName;
  final String latitude;
  final String long;

  Database(this.fullName, this.latitude, this.long);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference library = _store.collection('library');

    Future<void> updateUserData() {
      // Call the user's CollectionReference to add a new user
      return library
          .add({
            'full_name': fullName, // John Doe
            'latitude': latitude, // Stokes and Sons
            'longitude': long // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return ButtonTheme(
      child: FlatButton(
        padding: EdgeInsets.all(150),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Send Request",
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        onPressed: () => updateUserData(),
      ),
    );
  }
}
