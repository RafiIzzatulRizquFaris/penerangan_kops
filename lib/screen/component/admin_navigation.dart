import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penerangan_kops/screen/admin/data_user.dart';
import 'package:penerangan_kops/screen/admin/guide.dart';
import 'package:penerangan_kops/screen/attendence/attendence.dart';
import 'package:penerangan_kops/screen/profile.dart';

import '../../constants.dart';

class AdminNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminNavigationScreen();
  }
}

class AdminNavigationScreen extends State<AdminNavigation> {
  int selectedIndex = 0;
  List<Widget> _mainPage = [
    DataUser(),
    Attandence(),
    Guide(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _mainPage.elementAt(selectedIndex),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: onTapNavigationItem,
            selectedItemColor: AppColor.primaryColor,
            showSelectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: AppColor.blackColor,),
                label: "Data Anggota",
                activeIcon: Icon(Icons.home, color: AppColor.redColor,),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today, color: AppColor.blackColor,),
                label: "Rekap Presensi",
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
