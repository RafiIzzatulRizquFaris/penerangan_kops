import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:penerangan_kops/contract/change_password_contract.dart';
import 'package:penerangan_kops/contract/logout_contract.dart';
import 'package:penerangan_kops/presenter/change_password_presenter.dart';
import 'package:penerangan_kops/presenter/logout_presenter.dart';
import 'package:penerangan_kops/screen/login.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
    implements LogoutContractView, ChangePasswordContractView {
  SharedPreferences preferences;
  ProgressDialog loadingDialog;
  LogoutPresenter logoutPresenter;
  ChangePasswordPresenter changePasswordPresenter;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String name = "Unknown";

  _ProfileState() {
    logoutPresenter = LogoutPresenter(this);
    changePasswordPresenter = ChangePasswordPresenter(this);
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
      message: "Loading",
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
          width: MediaQuery
              .of(context)
              .size
              .width,
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
                  onTap: () {
                    showBottomSheetPassword(context);
                  },
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
                            style: TextStyle(
                                color: AppColor.primaryColor, fontSize: 20),
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
                            style: TextStyle(
                                color: AppColor.primaryColor, fontSize: 20),
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
    if (status == "success") {
      await loadingDialog.hide();
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return Login();
      }));
    }
  }

  void showBottomSheetPassword(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (context) {
          return Container(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    "Ganti Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColor.accentColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: TextField(
                        controller: oldPasswordController,
                        style: TextStyle(
                          color: AppColor.accentColor,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Password Lama',
                          labelStyle: TextStyle(
                            color: AppColor.accentColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColor.accentColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColor.accentColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: TextField(
                        controller: newPasswordController,
                        style: TextStyle(
                          color: AppColor.accentColor,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Password Baru',
                          labelStyle: TextStyle(
                            color: AppColor.accentColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColor.accentColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColor.accentColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: TextField(
                        controller: confirmPasswordController,
                        style: TextStyle(
                          color: AppColor.accentColor,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Konfirmasi Password',
                          labelStyle: TextStyle(
                            color: AppColor.accentColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColor.accentColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColor.accentColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                      right: 50,
                      left: 50,
                    ),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 50,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                        color: AppColor.accentColor,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: FlatButton(
                        onPressed: () async {
                          if (oldPasswordController.text.toString().trim() ==
                              preferences.get(PreferenceKey.password)
                                  .toString()) {
                            if (newPasswordController.text
                                .toString()
                                .trim()
                                .isNotEmpty &&
                                confirmPasswordController.text
                                    .toString()
                                    .trim()
                                    .isNotEmpty) {
                              if (newPasswordController.text
                                  .toString()
                                  .trim()
                                  .length >= 8 &&
                                  confirmPasswordController.text
                                      .toString()
                                      .trim()
                                      .length >= 8) {
                                if (newPasswordController.text.toString().trim() ==
                                    confirmPasswordController.text.toString()
                                        .trim()) {
                                  await loadingDialog.show();
                                  changePasswordPresenter.loadPasswordData(
                                      newPasswordController.text.toString().trim());
                                } else {
                                  errorAlert("Error", "Password baru tidak sama");
                                }
                              } else {
                                errorAlert("Error", "Password baru harus lebih atau sama dengan 8 karakter");
                              }
                            } else {
                              errorAlert("Error", "Password baru tidak boleh kosong");
                            }
                          } else {
                            errorAlert("Error", "Password lama tidak sama");
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Konfirmasi",
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  onErrorChangePassword(error) async {
    print(error.toString());
    await loadingDialog.hide();
    errorAlert("Error", "Gagal merubah password. \n Sesuatu terjadi");
  }

  @override
  onSuccessChangePassword(String status) async {
    if (status == "success"){
      await loadingDialog.hide();
      Alert(
        context: context,
        title: "Sukses",
        desc: "Anda berhasil mengubah password",
        type: AlertType.success,
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Ok",
              style: TextStyle(
                  color: AppColor.primaryColor, fontSize: 20),
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
    } else {
      await loadingDialog.hide();
      errorAlert("Error", "Gagal merubah password");
    }
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
            style: TextStyle(color: Colors.white, fontSize: 20),
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
          color: Colors.red,
        ),
        alertAlignment: Alignment.center,
      ),
    ).show();
  }
}
