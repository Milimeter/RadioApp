import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/Screen/radio_screen.dart';

void main() => runApp(StreamProvider<DataConnectionStatus>(
      create: (_) {
        return DataConnectionChecker().onStatusChange;
      },
      child: MaterialApp(
        home: RadioSplash(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        title: "Radio East",
      ),
    ));

class RadioSplash extends StatefulWidget {
  @override
  _RadioSplashState createState() => _RadioSplashState();
}

class _RadioSplashState extends State<RadioSplash> {
  @override
  initState() {
    super.initState();
    navigate();
  }

  navigate() {
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => RadioPlayerScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            'assets/images/center.jpg',
            fit: BoxFit.cover,
            // height: 300,
            // width: 300
          )),
          Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 40, top: 70),
              child: Text(
                "Radio East",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              )),
        ],
      ),
    );
  }
}
