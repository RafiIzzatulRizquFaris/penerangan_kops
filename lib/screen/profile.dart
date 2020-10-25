import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:penerangan_kops/contract/logout_contract.dart';
import 'package:penerangan_kops/presenter/logout_presenter.dart';
import 'package:penerangan_kops/screen/login.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> implements LogoutContractView {
  SharedPreferences preferences;
  ProgressDialog loadingDialog;
  LogoutPresenter logoutPresenter;
  String name = "Unknown";

  _ProfileState(){
    logoutPresenter = LogoutPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    initializePreference();
  }

  @override
  Widget build(BuildContext context) {

    loadingDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    loadingDialog.style(
      message: "Keluar",
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
                  height: 10,
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
                  onTap: () async {
                    Alert(
                      context: context,
                      title: "Keluar Akun",
                      desc: "Apakah anda yakin untuk mengeluarkan akun?",
                      type: AlertType.info,
                      buttons: [
                        DialogButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Batal",
                            style: TextStyle(color: AppColor.primaryColor, fontSize: 20),
                          ),
                          color: Colors.grey,
                        ),
                        DialogButton(
                          onPressed: () async {
                            await loadingDialog.show();
                            logoutPresenter.loadLogoutData();
                            Navigator.pop(context);

                          },
                          child: Text(
                            "Setuju",
                            style: TextStyle(color: AppColor.primaryColor, fontSize: 20),
                          ),
                        ),
                      ],
                      style: AlertStyle(
                        animationType: AnimationType.grow,
                        isCloseButton: false,
                        isOverlayTapDismiss: false,
                        descStyle: TextStyle(fontWeight: FontWeight.bold),
                        descTextAlign: TextAlign.center,
                        animationDuration: Duration(milliseconds: 400),
                        alertBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        titleStyle: TextStyle(
                          color: AppColor.accentColor,
                        ),
                        alertAlignment: Alignment.center,
                      ),
                    ).show();
                  },
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

  @override
  onErrorLogout(error) {
    print(error.toString());
  }

  @override
  onSuccessLogout(String status) async {
    if (status == "success"){
      await loadingDialog.hide();
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return Login();
      }));
    }
  }
}
