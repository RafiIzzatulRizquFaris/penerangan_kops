import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';

class Guide extends StatefulWidget {
  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  int _currentSteps = 0;

  List<Step> _stepAccount() {
    List<Step> _steps = [
      Step(
          title: Text("Buka Firebase Console di Google"),
          content: Text(
            "Search firebase console di google atau buka link console.firebase.google.com",
            style: TextStyle(color: AppColor.blackColor),
          )),
      Step(
          title: Text("Login menggunakan akun yang sudah ada"),
          content: Text(
            "Kami sudah menyiapkan sebuah akun google firebase dan dapat dipakai untuk login",
            style: TextStyle(color: AppColor.blackColor),
          )),
      Step(
          title: Text("Buka project penerangan-kops"),
          content: Text(
              "Pada table project silahkan memilih project penerangan-korps",
              style: TextStyle(color: AppColor.blackColor))),
      Step(
          title: Text("Buka Cloud Firestore"),
          content: Text(
            "Pada tampilan menu terdapat beberapa menu, pilihlah Cloud Firestore",
            style: TextStyle(color: AppColor.blackColor),
          )),
      Step(
          title: Text("Pilih user collection"),
          content: Text(
            "Pada tampilan table di Cloud Firestore, pilihlah koleksi user / user collection",
            style: TextStyle(color: AppColor.blackColor),
          )),
      Step(
          title: Text("Menambahkan Akun"),
          content: Text(
            "Setelah memilih koleksi user, tekan tombol Tambahkan Dokumen lalu isi: \nID Dokumen dengan ID Otomatis \nlalu kolom 1 yaitu id(string) dan isikan nilainya dengan id dipunya \nkolom ke 2 yaitu name(string) dan isikan nilainya dengan nama masing - masing \nkolom ke 3 yaitu password(string) dan isikan nilainya dengan password yang diinginkan",
            textAlign: TextAlign.start,
            style: TextStyle(color: AppColor.blackColor),
          )),
      Step(
          title: Text("(Tambahan)"),
          content: Text(
            "Kita juga membuat video youtube untuk mempermudah berikut adalah liknya",
            style: TextStyle(color: AppColor.blackColor),
          )),
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.menu_book_rounded, size: 100, color: AppColor.primaryColor,),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Panduan Registrasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Stepper(
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Row(
                  children: [
                    FlatButton(
                      onPressed: onStepContinue,
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: onStepCancel,
                      child: Text(
                        "Back",
                        style: TextStyle(
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ],
                );
              },
              onStepContinue: () {
                if (_currentSteps <= 0) {
                  setState(() {
                    _currentSteps += 1;
                  });
                }
              },
              onStepCancel: () {
                if (_currentSteps != 0) {
                  setState(() {
                    _currentSteps -= 1;
                  });
                }
              },
              onStepTapped: (step) {
                setState(() {
                  this._currentSteps = step;
                });
              },
              steps: _stepAccount(),
              currentStep: _currentSteps,
            ),
          ),
        ],
      ),
    );
  }
}
