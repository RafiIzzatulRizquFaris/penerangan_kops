import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginScreen();
  }
}

class LoginScreen extends State<Login>{

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoading;
  var isError;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    isError = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor().accentColor,
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColor().primaryColor,
          ),
        )
            : ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    verticalTitle(),
                    textLogin(),
                  ],
                ),
                inputId(),
                inputPassword(),
                buttonLogin(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  verticalTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 60, left: 10),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(
          "Masuk",
          style: TextStyle(
              color: AppColor().primaryColor, fontSize: 38, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  textLogin() {
    return Padding(
      padding: EdgeInsets.only(top: 50, left: 10),
      child: Container(
        height: 200,
        width: 200,
        child: Column(
          children: [
            Container(
              height: 60,
            ),
            Center(
              child: Text(
                "Sistem Presensi \nPenerangan Kopassus",
                style: TextStyle(
                  fontSize: 24,
                  color: AppColor().primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  inputId() {
    return Padding(
      padding: EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: idController,
          style: TextStyle(
            color: AppColor().primaryColor,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: AppColor().accentColor,
            labelText: "ID",
            labelStyle: TextStyle(
              color: AppColor().primaryColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor().primaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor().primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  inputPassword() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: passwordController,
          style: TextStyle(
            color: AppColor().primaryColor,
          ),
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Password',
            labelStyle: TextStyle(
              color: AppColor().primaryColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor().primaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor().primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  buttonLogin() {
    return Padding(
      padding: EdgeInsets.only(top: 50, right: 50, left: 50,),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: FlatButton(
          onPressed: () {
            if (idController.text.trim().length > 0 &&
                passwordController.text.trim().length > 0) {
              setState(() {
                isLoading = true;
                isError = false;
              });
              // loginPresenter.loadLoginData(
              //     idController.text.trim(), passwordController.text.trim());
            } else if (idController.text.trim().length == 0) {
              errorAlert("Empty Email", "Please fill email field");
            } else if (passwordController.text.trim().length == 0) {
              errorAlert("Empty Password", "Please fill password field");
            } else if (idController.text.trim().length == 0 &&
                passwordController.text.trim().length == 0) {
              errorAlert(
                  "Empty Field", "Make sure you fill all the field required");
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Masuk",
                style: TextStyle(
                  color: AppColor().accentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColor().accentColor,
              ),
            ],
          ),
        ),
      ),
    );
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
        descTextAlign: TextAlign.start,
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