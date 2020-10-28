import 'package:flutter/material.dart';
import 'package:penerangan_kops/admin_navigation.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:penerangan_kops/contract/login_contract.dart';
import 'package:penerangan_kops/main_navigation.dart';
import 'package:penerangan_kops/presenter/login_presenter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreen();
  }
}

class LoginScreen extends State<Login> implements LoginContractView {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginPresenter _loginPresenter;
  var isLoading;
  var isError;

  LoginScreen() {
    _loginPresenter = LoginPresenter(this);
  }

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
        color: AppColor.accentColor,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColor.primaryColor,
                ),
              )
            : Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Hero(
                      tag: 'kopassus',
                      child: Image.asset(
                        "assets/kopassus.png",
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                      ),
                    ),
                    horizontalTitle(),
                    textLogin(),
                    inputId(),
                    inputPassword(),
                    buttonLogin(),
                  ],
                ),
              ),
      ),
    );
  }

  horizontalTitle() {
    return Text(
      "Masuk",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppColor.primaryColor,
          fontSize: 38,
          fontWeight: FontWeight.w900),
    );
  }

  textLogin() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10),
      child: Container(
        child: Column(
          children: [
            Center(
              child: Text(
                "Sistem Presensi \nPenerangan Kopassus",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
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
            color: AppColor.primaryColor,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: AppColor.accentColor,
            labelText: "ID",
            labelStyle: TextStyle(
              color: AppColor.primaryColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor.primaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor.primaryColor,
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
            color: AppColor.primaryColor,
          ),
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Password',
            labelStyle: TextStyle(
              color: AppColor.primaryColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor.primaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  buttonLogin() {
    return Padding(
      padding: EdgeInsets.only(
        top: 50,
        right: 50,
        left: 50,
      ),
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
              _loginPresenter.loadLoginData(
                  idController.text.trim(), passwordController.text.trim());
            } else if (idController.text.trim().length == 0) {
              errorAlert("Empty id", "Please fill id field");
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
                  color: AppColor.accentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColor.accentColor,
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

  @override
  setLoginData(List<String> response) {
    if (response != null) {
      if (response[0] == LoginResponse.SUCCESS) {
        setState(() {
          isLoading = false;
          isError = false;
        });
        if (!isLoading && !isError && response[1] == "0") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MainNavigation();
          }));
        } else if (!isLoading && !isError && response[1] == "1") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return AdminNavigation();
          }));
        } else {
          errorAlert("Error", "Something Wrong");
        }
      } else if (response[0] == LoginResponse.WRONG_PASSWORD) {
        setState(() {
          isError = true;
          isLoading = false;
        });
        errorAlert("Wrong Password", "Wrong password on your account");
      } else if (response[0] == LoginResponse.FAILED) {
        setState(() {
          isError = true;
          isLoading = false;
        });
        errorAlert("Failed", "Please contact the admin to ask for account");
      }
    } else {
      setState(() {
        isError = true;
        isLoading = false;
      });
      errorAlert("Data not found", "Check your connection");
    }
  }

  @override
  setOnErrorLogin(error) {
    setState(() {
      isError = true;
      isLoading = false;
    });
    print(error);
    errorAlert("Data not found", "Check your connection");
  }
}
