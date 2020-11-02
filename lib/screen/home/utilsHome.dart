import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../constants.dart';
import 'package:intl/intl.dart';

class UtilsHome {
  static String todayDate(BuildContext context) {
    DateTime today = DateTime.now();
    String languageCode = Localizations.localeOf(context).languageCode;
    DateFormat format = DateFormat('dd MMMM yyyy', languageCode);
    return format.format(today);
  }

  static Future<String> futureName(data) async {
    Firestore firestore = Firestore.instance;
    QuerySnapshot snapshot = await firestore
        .collection('user')
        .where(
          "nrp",
          isEqualTo: data,
        )
        .getDocuments();
    return snapshot.documents[0].data['name'];
  }

  static alertLocation(String title, String subtitle, BuildContext context) {
    return Alert(
      context: context,
      title: title,
      desc: subtitle,
      type: AlertType.warning,
      buttons: [
        DialogButton(
          onPressed: () {
            AppSettings.openLocationSettings();
            Navigator.pop(context);
          },
          child: Text(
            "OK",
            style: TextStyle(color: AppColor.primaryColor, fontSize: 20),
          ),
        ),
      ],
      style: AlertStyle(
        animationType: AnimationType.grow,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        descTextAlign: TextAlign.start,
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: AppColor.redColor,
        ),
        alertAlignment: Alignment.center,
      ),
    ).show();
  }

// distanceMeter() async {
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//   var distance = Geolocator.distanceBetween(
//       position.latitude, position.longitude, Location.LAT, Location.LONG);
//   setState(() {
//     distanceDouble = distance;
//   });
// }

  static errorAlert(String title, String subtitle, BuildContext context) {
    return Alert(
      context: context,
      title: title,
      desc: subtitle,
      type: AlertType.warning,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "OK",
            style: TextStyle(color: AppColor.primaryColor, fontSize: 20),
          ),
        ),
      ],
      style: AlertStyle(
        animationType: AnimationType.grow,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        descTextAlign: TextAlign.start,
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: AppColor.redColor,
        ),
        alertAlignment: Alignment.center,
      ),
    ).show();
  }
}
