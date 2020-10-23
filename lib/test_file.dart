import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TestingPlaceholder extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TestingPlaceholderScreen();
  }

}

class TestingPlaceholderScreen extends State<TestingPlaceholder>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getDateNow()),
            Text(getLatLong()),
          ],
        ),),
      ),
    );
  }

  String getDateNow() {
    var date = DateTime.now();
    return "${date.year}-${date.month}-${date.day}";
  }

  String getLatLong() {
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var distance = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
    // return "Lat : ${position.latitude.toString()} \n Lang : ${position.longitude.toString()} \n Distance : ${distance.toString()}M";
    return "Distance : ${distance.toString()}M";
  }
}