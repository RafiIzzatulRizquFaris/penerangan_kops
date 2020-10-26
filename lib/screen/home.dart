import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:penerangan_kops/contract/absensi_contract.dart';
import 'package:penerangan_kops/presenter/absensi_presenter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> implements AbsensiContractView {
  AbsensiPresenter absensiPresenter;
  List<DocumentSnapshot> listAbsensi = List<DocumentSnapshot>();
  Environment env = Environment();
  SharedPreferences preferences;
  ProgressDialog loadingDialog;
  var isLoadData;
  String name = "Unknown";
  String id;
  double distanceDouble = 0.00;

  _HomeState() {
    absensiPresenter = AbsensiPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    distanceMeter();
    initializeDateFormatting();
    isLoadData = true;
    initializePreference();
    absensiPresenter.loadAbsensiData(env.getDateNow());
  }

  @override
  Widget build(BuildContext context) {
    loadingDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    loadingDialog.style(
      message: "Memasukkan data absensi",
      progressWidget: Container(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          backgroundColor: AppColor.accentColor,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(color: AppColor.accentColor),
    );

    return Scaffold(
      body: Column(
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
                  left: 20,
                  right: 10,
                  bottom: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                          ),
                          child: Text(
                            "Jarak Absensi : ${distanceDouble.toStringAsFixed(2).toString()} Meter",
                            style: TextStyle(
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            size: 24.0,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            if (!(await Geolocator
                                .isLocationServiceEnabled())) {
                              alertLocation("Lokasi Anda Tidak Aktif",
                                  "Silahkan aktifkan GPS anda", context);
                            } else {
                              Position position =
                                  await Geolocator.getCurrentPosition(
                                      desiredAccuracy: LocationAccuracy.high);
                              var distance = Geolocator.distanceBetween(
                                position.latitude,
                                position.longitude,
                                Location.LAT,
                                Location.LONG,
                              );
                              setState(() {
                                isLoadData = true;
                                distanceDouble = distance;
                              });
                              absensiPresenter
                                  .loadAbsensiData(env.getDateNow());
                            }
                          },
                          splashColor: Colors.lightGreenAccent,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Selamat Datang",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Icon(
                      Icons.account_circle,
                      color: AppColor.primaryColor,
                      size: 100,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                todayDate(),
                style: TextStyle(
                    color: AppColor.redColor, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Expanded(
            child: isLoadData
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColor.accentColor,
                    ),
                  )
                : listAbsensi.isEmpty
                    ? Center(
                        child: Text(
                          "Data Absensi Kosong",
                          style: TextStyle(
                            color: AppColor.accentColor,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: listAbsensi.length,
                        itemBuilder: builderAbsensi,
                      ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (!(await Geolocator.isLocationServiceEnabled())) {
            alertLocation("Lokasi Anda Tidak Aktif",
                "Silahkan aktifkan GPS anda", context);
          } else {
            await loadingDialog.show();
            Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            var distance = Geolocator.distanceBetween(position.latitude,
                position.longitude, Location.LAT, Location.LONG);
            if (distance <= Location.MAX_DISTANCE) {
              absensiPresenter.loadAbsen(id, name, env.getTimeNow(),
                  distance.toStringAsFixed(2), env.getDateNow());
            } else {
              await loadingDialog.hide();
              errorAlert("Gagal Absen",
                  "Jarak anda terlalu jauh, silahkan lebih dekat dengan lokasi yang ditentukan");
            }
          }
        },
        backgroundColor: AppColor.redColor,
        icon: Icon(Icons.location_on),
        splashColor: AppColor.accentColor,
        label: Text(
          "Absen Sekarang",
          style: TextStyle(
            color: AppColor.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  onErrorAbsen(error) async {
    print(error.toString());
    await loadingDialog.hide();
    errorAlert("Gagal Absen", "Sesuatu bermasalah,silahkan hubungi pengembang");
  }

  @override
  onSuccessAbsen(String status) async {
    if (status != null) {
      if (status == AbsenResponse.SUCCESS) {
        setState(() {
          isLoadData = true;
        });
        absensiPresenter.loadAbsensiData(env.getDateNow());
        print("Success");
        await loadingDialog.hide();
      } else if (status == AbsenResponse.ALREADY) {
        print("already");
        await loadingDialog.hide();
        errorAlert("Sudah Absen",
            "Terimakasih, anda sudah absen. Tidak perlu absen lagi");
      } else {
        print("failed");
        await loadingDialog.hide();
        errorAlert("Gagal Absen", "Silahkan cek koneksi dan nyalakan GPS");
      }
    } else {
      print("failed");
      await loadingDialog.hide();
      errorAlert("Gagal Absen", "Silahkan cek koneksi dan nyalakan GPS");
    }
  }

  @override
  setAbsensiData(List<DocumentSnapshot> value) {
    setState(() {
      listAbsensi = value;
      isLoadData = false;
    });
  }

  @override
  setOnErrorAbsensi(error) async {
    print(error.toString());
  }

  Widget builderAbsensi(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(
          Icons.person,
          color: AppColor.blackColor,
          size: 40,
        ),
        title: Text(
          listAbsensi[index].data["name"],
          style: TextStyle(
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.0),
        ),
        trailing: Text(
          listAbsensi[index].data["time"],
          style: TextStyle(fontSize: 20.0, color: AppColor.blackColor),
        ),
        subtitle: Text(
          "${listAbsensi[index].data["range"]} Meter",
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
    );
  }

  initializePreference() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.get(PreferenceKey.name).toString();
      id = preferences.get(PreferenceKey.id).toString();
    });
  }

  errorAlert(String title, String subtitle) {
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

  String todayDate() {
    DateTime today = DateTime.now();
    String languageCode = Localizations.localeOf(context).languageCode;
    DateFormat format = DateFormat('dd MMMM yyyy', languageCode);
    return format.format(today);
  }

  distanceMeter() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, Location.LAT, Location.LONG);
    setState(() {
      distanceDouble = distance;
    });
  }

  alertLocation(String title, String subtitle, BuildContext context) {
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
}
