import 'package:flutter/material.dart';

class AppColor{
  static const Color redColor = Color(0xfffd7062);
  static const Color primaryColor = Color(0xffeff8e8);
  static const Color blackColor = Color(0xff172c33);
  static const Color accentColor = Color(0xff689575);
}

class PreferenceKey{
  static const String id = "id";
  static const String name = "name";
  static const String password = "password";
}

class LoginResponse{
  static const String WRONG_PASSWORD = "wrong_password";
  static const String FAILED = "failed";
  static const String SUCCESS = "success";
}

class AbsenResponse{
  static const String SUCCESS = "success";
  static const String FAILED = "failed";
  static const String ALREADY = "already";
}

class Environment {
  String getDateNow(){
    var date = DateTime.now();
    return "${date.year}-${date.month}-${date.day}";
  }
  String getTimeNow(){
    var date = DateTime.now();
    return "${date.hour}:${date.minute}";
  }
}

class Location{
  static const double LAT = -6.318920;
  static const double LONG = 106.852008;
  static const double MAX_DISTANCE = 1000.00;
}