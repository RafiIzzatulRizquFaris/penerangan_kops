import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppColor{
  static const Color redColor = Color(0xfffd7062);
  static const Color primaryColor = Color(0xffeff8e8);
  static const Color blackColor = Color(0xff172c33);
  static const Color accentColor = Color(0xff689575);
}

class PreferenceKey{
  static const String documentId = "document_id";
  static const String id = "nrp";
  static const String name = "name";
  static const String password = "password";
  static const String isAdmin = "isadmin";
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
    var date = DateFormat.Hm().format(DateTime.now());
    return "${date.split(':')[0]}:${date.split(':')[1]}";
  }
}

class Location{
  static const double LAT = -6.318920;
  static const double LONG = 106.852008;
  static const double MAX_DISTANCE = 1000.00;
}