import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';
import 'constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              color: AppColor.accentColor,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.refresh,
                              size: 24.0,
                              color: Colors.white,
                            ),
                            onPressed: null),
                      ],
                    ),
                    Text(
                      "Selamat Datang",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Kelalawar",
                      style: TextStyle(
                          fontSize: 34.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )),
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Text(
                  "20 Oktober 2020",
                  style: TextStyle(
                      color: AppColor.redColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: AppColor.blackColor,
                    size: 40,
                  ),
                  title: Text(
                    "Kelelawar",
                    style: TextStyle(
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                  ),
                  trailing: Text(
                    "09:10",
                    style:
                        TextStyle(fontSize: 20.0, color: AppColor.blackColor),
                  ),
                  subtitle: Text(
                    "990 M",
                    style: TextStyle(color: AppColor.blackColor),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: AppColor.blackColor,
                    size: 40,
                  ),
                  title: Text(
                    "Kelelawar",
                    style: TextStyle(
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                  ),
                  trailing: Text(
                    "09:10",
                    style:
                        TextStyle(fontSize: 20.0, color: AppColor.blackColor),
                  ),
                  subtitle: Text(
                    "990 M",
                    style: TextStyle(color: AppColor.blackColor),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
     
      floatingActionButton: FloatingActionButton(onPressed: null,backgroundColor: AppColor.redColor,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
