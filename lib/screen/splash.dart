import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:penerangan_kops/admin_navigation.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:penerangan_kops/screen/login.dart';
import 'package:penerangan_kops/main_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        color: AppColor.accentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'kopassus',
                  child: Image.asset(
                    "assets/kopassus.png",
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeAnimatedTextKit(
                  text: ["Sistem Presensi \nPenerangan Kopassus"],
                  totalRepeatCount: 5,
                  duration: Duration(seconds: 5),
                  pause: Duration(seconds: 1),
                  displayFullTextOnTap: true,
                  textStyle: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
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
    var id = preferences.get(PreferenceKey.id);
    var password = preferences.get(PreferenceKey.password);
    var name = preferences.get(PreferenceKey.name);
    var admin = preferences.get(PreferenceKey.isAdmin);
    if (id == null && password == null && name == null){
      startLaunching();
    } else {
      print("not null");
      if (admin.toString() == "0") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return MainNavigation();
        }));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return AdminNavigation();
        }));
      }
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