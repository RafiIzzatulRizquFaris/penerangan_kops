import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SplashScreen();
  }

}

class SplashScreen extends State<Splash> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor().accentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/lambang_kopassus.png",
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotateAnimatedTextKit(
                  text: ["Select Your", "Future Leader"],
                  totalRepeatCount: 5,
                  pause: Duration(seconds: 1),
                  displayFullTextOnTap: true,
                  textStyle: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: AppColor().primaryColor,
                  ),
                  textAlign: TextAlign.center,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkData();
  }

  checkData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var name = preferences.get("nama");
    var password = preferences.get("password");
    if (name.toString() != null && password.toString() != null){
      startLaunching();
    } else {
    //  masukin ke home langsung
    }
  }

  startLaunching() {
    var duration = Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return Login();
      }));
    });
  }
}