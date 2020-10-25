import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPreferences preferences;
  String name = "Unknown";

  @override
  void initState() {
    super.initState();
    initializePreference();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColor.accentColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Column(
                children: [
                  Text(
                    "Manajemen Profil",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.account_circle,
                    color: AppColor.primaryColor,
                    size: 70,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Text(
                  "Profil",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.vpn_key_rounded,
                    color: AppColor.blackColor,
                  ),
                  title: Text(
                    "Ubah Password",
                    style:
                        TextStyle(color: AppColor.blackColor, fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Manajemen Akun",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app_rounded,
                    color: AppColor.blackColor,
                  ),
                  title: Text(
                    "Keluar Akun",
                    style:
                        TextStyle(color: AppColor.blackColor, fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Sistem Presensi Penerangan Kopassus \n V1.0.0",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  initializePreference() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.get(PreferenceKey.name).toString();
    });
  }
}
