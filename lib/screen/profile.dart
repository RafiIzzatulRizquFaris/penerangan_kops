import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 160,
          color: AppColor.accentColor,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Icon(Icons.account_circle, color: AppColor.primaryColor,size: 70,),
                SizedBox(height: 14,),
                Text("Kelelawar", style: TextStyle(color: AppColor.primaryColor,fontSize: 20, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        )
      ],
    );
  }
}
