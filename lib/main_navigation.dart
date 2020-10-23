import 'package:flutter/material.dart';
import 'package:penerangan_kops/screen/attendence.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:penerangan_kops/screen/guide.dart';
import 'package:penerangan_kops/screen/home.dart';
import 'package:penerangan_kops/screen/profile.dart';

class MainNavigation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MainNavigationScreen();
  }

}

class MainNavigationScreen extends State<MainNavigation>{

  int selectedIndex = 0;
  List<Widget> _mainPage = [Home(), Attandence(), Guide(), Profile(),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainPage.elementAt(selectedIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColor.primaryColor,
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onTapNavigationItem,
          selectedItemColor: AppColor.primaryColor,
          showSelectedLabels: false,
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
      ),
    );
  }


  void onTapNavigationItem(int value) {
    setState(() {
      selectedIndex = value;
    });
  }
}