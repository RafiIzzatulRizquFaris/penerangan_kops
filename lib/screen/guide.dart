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
          title: Text("Buka Firestore"),
          content: Text(
            "test",
            style: TextStyle(color: AppColor.blackColor),
          )),
      Step(title: Text("Login "), content: Text("test")),
      Step(title: Text("s"), content: Text("test")),
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
            height: 85,
            decoration: BoxDecoration(
                color: AppColor.accentColor,
                borderRadius: BorderRadius.only(
                    // bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Panduan",
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ))),
        Expanded(
            child: Stepper(
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: [
                FlatButton(
                    onPressed: onStepContinue,
                    child: Text("Next",
                        style: TextStyle(color: AppColor.blackColor))),
                FlatButton(
                    onPressed: onStepCancel,
                    child: Text(
                      "Back",
                      style: TextStyle(color: AppColor.blackColor),
                    )),
              ],
            );
          },
          onStepContinue: () {
            if (_currentSteps != 1) {
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
        ))
      ],
    ));
  }
}
