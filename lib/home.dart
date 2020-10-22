import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: AppColor().accentColor,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "welcome",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                        ),
                    ),

                    Row(
                      
                      children: [
                        Icon(Icons.person, size: 30, color: Colors.white,),
                        SizedBox(width: 15,),
                        Text("Kelalawar", style: TextStyle(fontSize: 34.0, color: Colors.white, fontWeight: FontWeight.bold),)
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
