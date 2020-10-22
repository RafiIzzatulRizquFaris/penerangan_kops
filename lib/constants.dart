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