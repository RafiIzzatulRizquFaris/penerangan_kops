import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:penerangan_kops/screen/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penerangan Kops',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColor.accentColor,
        accentColor: AppColor.accentColor,
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}
