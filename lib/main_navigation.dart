import 'package:flutter/material.dart';
import 'package:penerangan_kops/attendence.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:penerangan_kops/guide.dart';
import 'package:penerangan_kops/home.dart';
import 'package:penerangan_kops/profile.dart';

class MainNavigation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MainNavigationScreen();
  }

}

class MainNavigationScreen extends State<MainNavigation>{

  int selectedIndex = 0;
  List<Widget> _mainPage = [
  //  ini diisi widget layout tampilan menu
  Home(),
  Attandence(),
  Guide(),
  Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainPage.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.accentColor,
        currentIndex: selectedIndex,
        onTap: onTapNavigationItem,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: AppColor.blackColor,),
            label: "Presensi",
            activeIcon: Icon(Icons.home, color: AppColor.redColor,),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: AppColor.blackColor,),
            label: "Kehadiran",
            activeIcon: Icon(Icons.calendar_today, color: AppColor.redColor,),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help, color: AppColor.blackColor,),
            label: "Panduan",
            activeIcon: Icon(Icons.help, color: AppColor.redColor,),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: AppColor.blackColor,),
            label: "Profil",
            activeIcon: Icon(Icons.person, color: AppColor.redColor,),
          ),
        ],
      ),
    );
  }


  void onTapNavigationItem(int value) {
    setState(() {
      selectedIndex = value;
    });
  }
}