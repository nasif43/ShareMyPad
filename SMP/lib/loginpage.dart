import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'auth.dart';
// import 'backend.dart';
import 'suck.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 600,
                  width: 600,
                  child: Image(image: AssetImage("gif/giphy.gif")),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(100.0, 110.0, 0.0, 0.0),
                  child: Text('Hello',
                      style: TextStyle(
                          fontSize: 120.0,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Bulgabia')),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(110.0, 200.0, 0.0, 0.0),
                  child: Text('There',
                      style: TextStyle(
                          fontSize: 120.0,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Bulgabia')),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(270.0, 230.0, 0.0, 0.0),
                  child: Text('.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Bulgabia',
                          color: Colors.pink)),
                )
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: 50.0,
            child: Material(
              borderRadius: BorderRadius.circular(60.0),
              elevation: 5.0,
              child: GestureDetector(
                onTap: () {
                  signInWithGoogle().then(
                    (user) => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapLocate()),
                      )
                    },
                  );
                },
                child: Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.pink,
                        fontSize: 50,
                        fontFamily: 'Bulgabia'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Courtesy of SquareOne',
                style: TextStyle(fontFamily: 'Montserrat'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
