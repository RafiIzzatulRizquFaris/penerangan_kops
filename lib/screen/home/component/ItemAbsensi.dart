import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../utilsHome.dart';

class ItemAbsensi extends StatelessWidget {
  DocumentSnapshot itemData;

  ItemAbsensi(DocumentSnapshot listAbsensi){
    itemData = listAbsensi;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(
          Icons.person,
          color: AppColor.blackColor,
          size: 40,
        ),
        title: FutureBuilder(
            future: UtilsHome.futureName(itemData.data["nrp"]),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Text(
                  "Unknown",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                );
              }
              return Text(
                snapshot.data,
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              );
            }),
        trailing: Text(
          itemData.data["time"],
          style: TextStyle(fontSize: 20.0, color: AppColor.blackColor),
        ),
        subtitle: Text(
          "${itemData.data["range"]} Meter",
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
    );
  }
}
