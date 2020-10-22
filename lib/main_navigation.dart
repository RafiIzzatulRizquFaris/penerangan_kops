import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';

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
            activeIcon: Icon(Icons.home, color: AppColor.primaryColor,),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: AppColor.blackColor,),
            label: "Daftar Hadir",
            activeIcon: Icon(Icons.list, color: AppColor.primaryColor,),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help, color: AppColor.blackColor,),
            label: "Panduan",
            activeIcon: Icon(Icons.help, color: AppColor.primaryColor,),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: AppColor.blackColor,),
            label: "Profil",
            activeIcon: Icon(Icons.person, color: AppColor.primaryColor,),
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