import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:penerangan_kops/contract/absensi_contract.dart';
import 'package:penerangan_kops/presenter/absensi_presenter.dart';
import '../constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> implements AbsensiContractView {
  AbsensiPresenter absensiPresenter;
  List<DocumentSnapshot> listAbsensi = List<DocumentSnapshot>();
  Environment env = Environment();
  var isLoadData;

  _HomeState() {
    absensiPresenter = AbsensiPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    isLoadData = true;
    absensiPresenter.loadAbsensiData(env.getDateNow());
  }

  @override
  Widget build(BuildContext context) {
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
                      "Kelalawar",
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
        onPressed: () {},
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
  onSuccessAbsen(String status) {
    // TODO: implement onSuccessAbsen
    throw UnimplementedError();
  }

  @override
  setAbsensiData(List<DocumentSnapshot> value) {
    setState(() {
      listAbsensi = value;
      isLoadData = false;
    });
  }

  @override
  setOnErrorAbsensi(error) {
    // TODO: implement setOnErrorAbsensi
    throw UnimplementedError();
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
}
