import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

  _HomeState() {
    absensiPresenter = AbsensiPresenter(this);
  }

  @override
  void initState() {
    super.initState();
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
          padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            color: AppColor.accentColor,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 10,
                  bottom: 10,
                ),
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
                          onPressed: () {
                            setState(() {
                              isLoadData = true;
                            });
                            absensiPresenter.loadAbsensiData(env.getDateNow());
                          },
                          splashColor: Colors.lightGreenAccent,
                        ),
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
                      name,
                      style: TextStyle(
                          fontSize: 34.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                "20 Oktober 2020",
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
          await loadingDialog.show();
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          var distance = Geolocator.distanceBetween(position.latitude,
              position.longitude, Location.LAT, Location.LONG);
          if (distance <= Location.MAX_DISTANCE) {
            absensiPresenter.loadAbsen(id, name, env.getTimeNow(),
                distance.toInt().toString(), env.getDateNow());
          } else {
            errorAlert("Gagal Absen", "Jarak anda terlalu jauh, silahkan lebih dekat dengan lokasi yang ditentukan");
          }
        },
        backgroundColor: AppColor.redColor,
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
  onErrorAbsen(error) {
    // TODO: implement onErrorAbsen
    throw UnimplementedError();
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
      } else if (status == AbsenResponse.ALREADY){
        print("already");
        await loadingDialog.hide();
        errorAlert("Sudah Absen", "Terimakasih, anda sudah absen. Tidak perlu absen lagi");
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
    await loadingDialog.hide();
    errorAlert("Gagal Absen", "Sesuatu bermasalah,silahkan hubungi pengembang");
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
          "${listAbsensi[index].data["range"]} M",
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
}
